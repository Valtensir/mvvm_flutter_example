import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';

import '../../../routing/routes.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo, required this.viewModel});

  final Todo todo;
  final TodoViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.todoDetails(todo.id)),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              viewModel.updateTodo.execute(todo.copyWith(done: value));
            },
          ),
          title: Text(todo.name),
          trailing: IconButton(
            onPressed: () => viewModel.deleteTodo.execute(todo),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
