import 'package:mvvm_example/utils/result/result.dart';
import 'package:mvvm_example/domain/models/todo.dart';

abstract class TodoRepository {
  Future<Result<List<Todo>>> get();
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  });
  Future<Result<Todo>> delete(Todo todo);
  Future<Result<Todo>> getTodoById(String id);
  Future<Result<Todo>> update(Todo todo);
}
