import 'package:flutter/material.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_example/ui/todo/widgets/add_todo_dialog.dart';
import 'package:mvvm_example/ui/todo/widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.viewModel});

  final TodoViewmodel viewModel;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    widget.viewModel.deleteTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    final command = widget.viewModel.deleteTodo;

    if (command.isRunning) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            content: Center(child: CircularProgressIndicator()),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: command.error ? Colors.red : Colors.green,
          content: command.error
              ? const Text('Error deleting todo')
              : const Text('Todo deleted successfully'),
        ),
      );
    }
  }

  @override
  void dispose() {
    widget.viewModel.deleteTodo.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          if (widget.viewModel.load.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.viewModel.load.error) {
            return const Center(child: Text('Loading Error:'));
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return TodoList(
              todos: widget.viewModel.todos,
              viewModel: widget.viewModel,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoDialog(viewmodel: widget.viewModel);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
