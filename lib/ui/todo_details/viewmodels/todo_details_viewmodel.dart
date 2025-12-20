import 'package:flutter/widgets.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/utils/commands/commands.dart';
import 'package:mvvm_example/utils/result/result.dart';

import '../../../domain/models/todo.dart';

class TodoDetailsViewmodel extends ChangeNotifier {
  final TodoRepository _repository;

  TodoDetailsViewmodel({required TodoRepository todoRepository})
    : _repository = todoRepository {
      load = Command1(_load);
    }

  late final Command1<Todo, String> load;

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
}
