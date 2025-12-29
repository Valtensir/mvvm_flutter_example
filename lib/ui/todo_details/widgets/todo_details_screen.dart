import 'package:flutter/material.dart';
import 'package:mvvm_example/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:mvvm_example/ui/todo_details/widgets/edit_todo_widget.dart';

import 'todo_description_widget.dart';
import 'todo_name_widget.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({super.key, required this.viewmodel});

  final TodoDetailsViewmodel viewmodel;

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listando detalhe do Todo')),
      body: ListenableBuilder(
        listenable: widget.viewmodel.load,
        builder: (context, child) {
          if (widget.viewmodel.load.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.viewmodel.load.error) {
            return const Center(
              child: Text('Erro: ao carregar os detalhes do Todo'),
            );
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.viewmodel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 8,
                children: [
                  TodoName(todo: widget.viewmodel.todo),
                  if (widget.viewmodel.todo.description.isNotEmpty)
                    TodoDescription(todo: widget.viewmodel.todo),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: EditTodoWidget(
                  todo: widget.viewmodel.todo,
                  todoDetailsViewmodel: widget.viewmodel,
                ),
              );
            },
          );
        },
        child: ListenableBuilder(
          listenable: widget.viewmodel.load,
          builder: (context, child) {
            if (widget.viewmodel.load.isRunning ||
                widget.viewmodel.load.error) {
              return const SizedBox.shrink();
            }
            return const Icon(Icons.edit);
          },
        ),
      ),
    );
  }
}
