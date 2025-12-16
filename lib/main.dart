import 'package:flutter/material.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository_dev.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:mvvm_example/ui/todo/widgets/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TodoScreen(
        viewModel: TodoViewmodel(repository: TodoRepositoryDev()),
      ),
    );
  }
}
