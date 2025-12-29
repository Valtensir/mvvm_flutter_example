import 'package:flutter/material.dart';
import 'package:mvvm_example/domain/models/todo.dart';

class TodoDescription extends StatelessWidget {
  const TodoDescription({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.lightBlue,
      ),
      child: Text(
        todo.description,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
