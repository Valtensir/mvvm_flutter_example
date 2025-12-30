import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_example/ui/todo_details/viewmodels/todo_details_viewmodel.dart';

import '../../../domain/models/todo.dart';

class EditTodoWidget extends StatefulWidget {
  const EditTodoWidget({
    super.key,
    required this.todo,
    required this.todoDetailsViewmodel,
  });

  final Todo todo;
  final TodoDetailsViewmodel todoDetailsViewmodel;

  @override
  State<EditTodoWidget> createState() => _EditTodoWidgetState();
}

class _EditTodoWidgetState extends State<EditTodoWidget> {
  late final _nameController = TextEditingController(
    text: widget.todo.name,
  );
  late final _descriptionController = TextEditingController(
    text: widget.todo.description,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.todoDetailsViewmodel.updateTodo.addListener(_onUpdateTodo);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    widget.todoDetailsViewmodel.updateTodo.removeListener(_onUpdateTodo);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            const Text("Editando todo"),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Nome",
                border: OutlineInputBorder(),
              ),

              validator: (value) {
                if (value!.isEmpty) {
                  return "Preencha o campo de nome";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: "Descrição",
                border: OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: null,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  widget.todoDetailsViewmodel.updateTodo.execute(
                    widget.todo.copyWith(
                      name: _nameController.text,
                      description: _descriptionController.text,
                    ),
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _onUpdateTodo() {
    final command = widget.todoDetailsViewmodel.updateTodo;
    if (command.isRunning) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialog(
            content: IntrinsicHeight(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    } else {
      context.pop();
      if (command.completed) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Todo editado com sucesso!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Erro ao editar Todo.'),
          ),
        );
      }
    }
  }
}
