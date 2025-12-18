import 'package:flutter/material.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.todo, required this.viewModel});

  final Todo todo;
  final TodoViewmodel viewModel;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(widget.todo.id),
      title: Text(widget.todo.name),
      trailing: IconButton(
        onPressed: () => widget.viewModel.deleteTodo.execute(widget.todo),
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
