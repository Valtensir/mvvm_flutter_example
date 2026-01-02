import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:mvvm_example/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_example/utils/result/result.dart';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = ApiClient(host: '192.168.1.2');
  });

  group("Test [ApiClient]", () {
    test("getTodos returns a Result Ok", () async {
      final result = await apiClient.getTodos();
      expect(result.asOk().value, isA<List<Todo>>());
    });

    test("create TODO returns a Result Ok", () async {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: "New TODO",
        description: "Test description",
        done: false,
      );
      final result = await apiClient.createTodo(todoToCreate);
      expect(result.asOk().value, isA<Todo>());
    });

    test("delete TODO returns a Result Ok", () async {
      final todos = await apiClient.getTodos() as Ok<List<Todo>>;
      if (todos.value.isEmpty) {
        const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
          name: "TODO to be deleted",
          description: "deleted TODO",
          done: false,
        );
        await apiClient.createTodo(todoToCreate);
      }
      final result = await apiClient.deleteTodo(todos.value.first);
      expect(result.asOk().value, isA<Todo>());
    });

    test("update TODO returns a Result Ok", () async {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: "TODO to be updated",
        description: "updated TODO",
        done: true,
      );
      final todoResult = await apiClient.createTodo(todoToCreate);
      final result = await apiClient.udpateTodo(
        UpdateTodoApiModel(
          id: todoResult.asOk().value.id,
          name: '${todoResult.asOk().value.name} + 2',
          description: "updated TODO",
          done: true,
        ),
      );
      expect(result.asOk().value, isA<Todo>());
    });

    test("get TODO by id returns a Result Ok", () async {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: "New test TODO",
        description: "new TODO",
        done: false,
      );
      final createdTodoResult = await apiClient.createTodo(todoToCreate);

      final result = await apiClient.getTodoById(
        createdTodoResult.asOk().value.id,
      );
      expect(result.asOk().value, isA<Todo>());
      expect(result.asOk().value.id, createdTodoResult.asOk().value.id);
    });
  });
}
