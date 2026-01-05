import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:mvvm_example/utils/result/result.dart';

import '../../mock/http_client_mock.dart';
import '../../mock/todo.dart';

void main() {
  late ApiClient apiClient;
  late HttpClientMock mockHttpClient;

  setUp(() {
    mockHttpClient = HttpClientMock();
    apiClient = ApiClient(httpClientFactory: () => mockHttpClient);
  });

  group("Test [ApiClient]", () {
    test("getTodos returns a Result Ok", () async {
      mockHttpClient.mockGet("/todos", mockGetTodos);
      final result = await apiClient.getTodos();
      expect(result.asOk().value, isA<List<Todo>>());
    });

    test("create TODO returns a Result Ok", () async {
      mockHttpClient.mockPost("/todos", mockTodoPostResponse);
      final result = await apiClient.createTodo(mockTodoPost);
      expect(result.asOk().value, isA<Todo>());
    });

    test("delete TODO returns a Result Ok", () async {
      mockHttpClient.mockDelete("/todos/1", updateTodoAlteradoMock);
      final result = await apiClient.deleteTodo(mockTodoPostResponse);
      expect(result.asOk().value, isA<Todo>());
    });

    test("update TODO returns a Result Ok", () async {
      mockHttpClient.mockPut("/todos/1", updateTodoAlteradoMock);

      final result = await apiClient.updateTodo(updateTodoMock);
      expect(result.asOk().value, isA<Todo>());
      expect(result.asOk().value.id, '1');
    });

    test("get TODO by id returns a Result Ok", () async {
      mockHttpClient.mockGet("/todos/1", addTodoMock);

      final result = await apiClient.getTodoById("1");
      expect(result.asOk().value, isA<Todo>());
      expect(result.asOk().value.id, "1");
    });
  });
}
