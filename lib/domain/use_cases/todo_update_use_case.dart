import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/utils/result/result.dart';

class TodoUpdateUseCase {
  final TodoRepository _todoRepository;

  TodoUpdateUseCase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _todoRepository.update(todo);

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
