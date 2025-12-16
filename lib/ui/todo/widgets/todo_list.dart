import 'package:flutter/material.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_example/ui/todo/widgets/todo_tile.dart';

import '../../../domain/models/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos, required this.viewModel});

  final List<Todo> todos;
  final TodoViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('No Todos Available'));
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index], viewModel: viewModel);
      },
    );
  }
}
