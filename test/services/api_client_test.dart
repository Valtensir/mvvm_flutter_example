import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
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
    final result = await apiClient.createTodo("New Todo");
    expect(result.asOk().value, isA<Todo>());
  });

  test("delete Todo returns a Result Ok", () async {
    final todos = await apiClient.getTodos() as Ok<List<Todo>>;
    if (todos.value.isEmpty) {
      await apiClient.createTodo("Todo to be deleted");
    }
    final result = await apiClient.deleteTodo(todos.value.first);
    expect(result.asOk().value, isA<Todo>());
  });
}
