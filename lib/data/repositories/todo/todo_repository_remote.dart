import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:mvvm_example/services/api/models/todo/todo_api_model.dart';

import 'package:mvvm_example/utils/result/result.dart';

import 'todo_repository.dart';

class TodoRepositoryRemote implements TodoRepository {
  final ApiClient _apiClient;

  TodoRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Result<Todo>> add(String name) async {
    try {
      final result = await _apiClient.createTodo(
        CreateTodoApiModel(name: name),
      );

      switch (result) {
        case Ok<Todo>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Todo>> delete(Todo todo) async {
    try {
      final result = await _apiClient.deleteTodo(todo);

      switch (result) {
        case Ok<Todo>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Todo>>> get() async {
    try {
      final result = await _apiClient.getTodos();

      switch (result) {
        case Ok<List<Todo>>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Todo>> getTodoById(String id) async {
    try {
      final result = await _apiClient.getTodoById(id);

      switch (result) {
        case Ok<Todo>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
