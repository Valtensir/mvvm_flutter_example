import 'package:flutter/material.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key, required this.viewmodel});

  final TodoViewmodel viewmodel;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    widget.viewmodel.addTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.viewmodel.addTodo.isRunning) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
    } else {
      if (widget.viewmodel.addTodo.completed) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Todo Added'),
          ),
        );
      } else if (widget.viewmodel.addTodo.error) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Todo add error'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    widget.viewmodel.addTodo.removeListener(_onResult);
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    const Text('Add Todo Dialog'),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Todo Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                     TextFormField(
                      minLines: 3,
                      maxLines: null,
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await widget.viewmodel.addTodo.execute((
                            _nameController.text,
                            _descriptionController.text,
                            false,
                          ));
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
