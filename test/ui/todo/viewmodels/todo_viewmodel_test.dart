import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository_dev.dart';
import 'package:mvvm_example/ui/todo/viewmodels/todo_viewmodel.dart';

void main() {
  late TodoRepository repository;
  late TodoViewmodel viewModel;

  setUp(() {
    repository = TodoRepositoryDev();
    viewModel = TodoViewmodel(repository: repository);
  });
  group("Should test TodoViewModel", () {
    test("Verifying ViewModel initial state", () async {
      expect(viewModel.todos, isEmpty);
    });

    test("Should add todo", () async {
      await viewModel.addTodo.execute(("New Todo Item", "", false));
      expect(viewModel.todos.length, 1);
      expect(viewModel.todos.last.name, "New Todo Item");
    });

    test("Should delete todo", () async {
      await viewModel.addTodo.execute(("New Todo Item", "", false));
      final todoToDelete = viewModel.todos.first;
      await viewModel.deleteTodo.execute(todoToDelete);
      expect(viewModel.todos.length, 0);
      expect(viewModel.todos.contains(todoToDelete), isFalse);
    });
  });
}
