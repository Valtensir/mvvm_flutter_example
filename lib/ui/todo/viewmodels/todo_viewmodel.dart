import 'package:flutter/foundation.dart';
import 'package:mvvm_example/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_example/utils/result/result.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';

import '../../../utils/commands/commands.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel({
    required TodoRepository repository,
    required TodoUpdateUseCase todoUpdateUseCase,
  }) : _repository = repository,
       _todoUpdateUseCase = todoUpdateUseCase {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);

    _repository.addListener((){
      _todos = _repository.todos;
      notifyListeners();
    });
  }

  final TodoRepository _repository;
  final TodoUpdateUseCase _todoUpdateUseCase;
  late Command0 load;
  late Command1<Todo, (String, String, bool)> addTodo;
  late Command1<Todo, Todo> deleteTodo;
  late Command1<Todo, Todo> updateTodo;

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<Result<List<Todo>>> _load() async {
    final result = await _repository.get();
    switch (result) {
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

  Future<Result<Todo>> _addTodo((String, String, bool) todo) async {
    final (name, description, done) = todo;
    final result = await _repository.add(
      name: name,
      description: description,
      done: done,
    );
    switch (result) {
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
    final result = await _repository.delete(todo);
    switch (result) {
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
