import 'package:logging/logging.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/utils/result/result.dart';

class TodoUpdateUseCase {
  final TodoRepository _todoRepository;
  final _log = Logger('TodoUpdateUseCase');

  TodoUpdateUseCase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _todoRepository.update(todo);

      switch (result) {
        case Ok<Todo>():
        _log.fine('TODO alterado');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e, stackTrace) {
      _log.warning('Erro ao alterar TODO', e, stackTrace);
      return Result.error(e);
    }
  }
}
