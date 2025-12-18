import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:mvvm_example/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_example/utils/result/result.dart';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = ApiClient();
  });

  group("Test [ApiClient]", () {
    test("getTodos returns a Result Ok", () async {
      final result = await apiClient.getTodos();
      expect(result.asOk().value, isA<List<Todo>>());
    });
  });

  test("create Todo returns a Result Ok", () async {
    const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
      name: "New Todo",
    );
    final result = await apiClient.createTodo(todoToCreate);
    expect(result.asOk().value, isA<Todo>());
  });

  test("delete Todo returns a Result Ok", () async {
    final todos = await apiClient.getTodos() as Ok<List<Todo>>;
    if (todos.value.isEmpty) {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: "Todo to be deleted",
      );
      await apiClient.createTodo(todoToCreate);
    }
    final result = await apiClient.deleteTodo(todos.value.first);
    expect(result.asOk().value, isA<Todo>());
  });

  test("update Todo returns a Result Ok", () async {
    const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
      name: "Todo to be updated",
    );
    final todoResult = await apiClient.createTodo(todoToCreate);
    final result = await apiClient.udpateTodo(
      UpdateTodoApiModel(
        id: todoResult.asOk().value.id,
        name: '${todoResult.asOk().value.name} + 2',
      ),
    );
    expect(result.asOk().value, isA<Todo>());
  });
}
