import 'package:flutter/widgets.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_example/utils/commands/commands.dart';
import 'package:mvvm_example/utils/result/result.dart';

import '../../../domain/models/todo.dart';

class TodoDetailsViewmodel extends ChangeNotifier {
  final TodoRepository _repository;
  final TodoUpdateUseCase _todoUpdateUseCase;
  late final VoidCallback _repositoryListener;

  TodoDetailsViewmodel({
    required TodoRepository todoRepository,
    required TodoUpdateUseCase todoUpdateUseCase,
  }) : _repository = todoRepository,
       _todoUpdateUseCase = todoUpdateUseCase {
    load = Command1(_load);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
    _repositoryListener = () {
      load.execute(_todo.id);
    };
    _repository.addListener(_repositoryListener);
  }

  late final Command1<Todo, String> load;
  late final Command1<Todo, Todo> updateTodo;

  late Todo _todo;
  Todo get todo => _todo;

  Future<Result<Todo>> _load(String id) async {
    try {
      final result = await _repository.getTodoById(id);

      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _repository.removeListener(_repositoryListener);
    super.dispose();
  }
}
