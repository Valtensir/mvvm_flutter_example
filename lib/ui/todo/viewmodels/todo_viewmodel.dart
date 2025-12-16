import 'package:flutter/foundation.dart';
import 'package:mvvm_example/utils/result/result.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';

import '../../../utils/commands/commands.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel({required TodoRepository repository})
    : _repository = repository {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
  }

  final TodoRepository _repository;
  late Command0 load;
  late Command1<Todo, String> addTodo;
  late Command1<Todo, Todo> deleteTodo;

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<Result<List<Todo>>> _load() async {
    final result = await _repository.get();
    switch(result) {
      case Ok<List<Todo>>():
        _todos = result.value;
        notifyListeners();
        break;
        case Error(): 
        //TODO: handle error
        break;
    }
    return result;
  }

  Future<Result<Todo>> _addTodo(String name) async {
    await Future.delayed(const Duration(seconds: 2));
    final result = await _repository.add(name);
    switch(result) {
      case Ok<Todo>():
        _todos.add(result.value);
        notifyListeners();
        break;
      case Error():
        //TODO: handle error
        break;
    }
    return result;
  }

  Future<Result<Todo>> _deleteTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2));
    final result = await _repository.delete(todo);
    switch(result) {
      case Ok<Todo>():
        _todos.remove(todo);
        notifyListeners();
        break;
      case Error():
       //TODO: handle error
        break;
    }
    return result;
  }
}
