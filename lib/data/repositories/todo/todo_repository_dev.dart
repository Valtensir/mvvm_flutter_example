import 'package:mvvm_example/utils/result/result.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';

class TodoRepositoryDev implements TodoRepository {
  final List<Todo> _todos = [];
  @override
  Future<Result<Todo>> add(String name) async {
    final lastTodoIndex = _todos.isNotEmpty ? _todos.length : 0;
    final newTodo = Todo(id: (lastTodoIndex + 1).toString(), name: name);
    return Result.ok(newTodo);
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
}
