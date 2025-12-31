import 'package:flutter/material.dart';
import 'package:mvvm_example/utils/result/result.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';

class TodoRepositoryDev extends ChangeNotifier implements TodoRepository {
  
  final List<Todo> _todos = [];
  @override
  List<Todo> get todos => _todos;

  @override
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    try {
      final lastTodoIndex = _todos.isNotEmpty ? _todos.length : 0;
      final newTodo = Todo(
        id: (lastTodoIndex + 1).toString(),
        name: name,
        description: description,
        done: done,
      );
      return Result.ok(newTodo);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<Todo>> delete(Todo todo) async {
    if (_todos.contains(todo)) {
      _todos.remove(todo);
      return Result.ok(todo);
    } else {
      return Result.error(Exception('Todo not found'));
    }
  }

  @override
  Future<Result<List<Todo>>> get() async {
    return Result.ok(_todos);
  }

  @override
  Future<Result<Todo>> getTodoById(String id) async {
    return Result.ok(_todos.where((element) => element.id == id).first);
  }

  @override
  Future<Result<Todo>> update(Todo todo) async {
    try {
      final todoIndex = _todos.indexWhere((t) => t.id == todo.id);
      _todos[todoIndex] = todo;
      return Result.ok(todo);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
