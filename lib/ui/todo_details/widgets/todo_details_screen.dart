import 'package:flutter/material.dart';
import 'package:mvvm_example/ui/todo_details/viewmodels/todo_details_viewmodel.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({
    super.key,
    required this.id,
    required this.viewmodel,
  });

  final String id;
  final TodoDetailsViewmodel viewmodel;

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listando detalhe do Todo')),
      body: Center(child: Text('Visualizando detalhes do Todo: ${widget.id}')),
    );
  }
}
