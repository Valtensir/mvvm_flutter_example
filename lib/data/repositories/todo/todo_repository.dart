import 'package:mvvm_example/utils/result/result.dart';
import 'package:mvvm_example/domain/models/todo.dart';

abstract class TodoRepository {
  Future<Result<List<Todo>>> get();
  Future<Result<Todo>> add(String name);
  Future<Result<Todo>> delete(Todo todo);
  Future<Result<Todo>> getTodoById(String id);
}