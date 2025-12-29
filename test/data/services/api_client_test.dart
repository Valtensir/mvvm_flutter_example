import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:mvvm_example/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_example/utils/result/result.dart';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = ApiClient(host: '192.168.1.12');
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
      description: "",
      done: false
    );
    final result = await apiClient.createTodo(todoToCreate);
    expect(result.asOk().value, isA<Todo>());
  });

  test("delete Todo returns a Result Ok", () async {
    final todos = await apiClient.getTodos() as Ok<List<Todo>>;
    if (todos.value.isEmpty) {
      const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
        name: "Todo to be deleted",
        description: "deleted todo",
        done: false
      );
      await apiClient.createTodo(todoToCreate);
    }
    final result = await apiClient.deleteTodo(todos.value.first);
    expect(result.asOk().value, isA<Todo>());
  });

  test("update Todo returns a Result Ok", () async {
    const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
      name: "Todo to be updated",
      description: "updated todo",
      done: true
    );
    final todoResult = await apiClient.createTodo(todoToCreate);
    final result = await apiClient.udpateTodo(
      UpdateTodoApiModel(
        id: todoResult.asOk().value.id,
        name: '${todoResult.asOk().value.name} + 2',
        description: "updated todo",
        done: true
      ),
    );
    expect(result.asOk().value, isA<Todo>());
  });

  test("get Todo by id returns a Result Ok", () async {
    const CreateTodoApiModel todoToCreate = CreateTodoApiModel(
      name: "New test todo",
      description: "new todo",
      done: false
    );
    final createdTodoResult = await apiClient.createTodo(todoToCreate);

    final result = await apiClient.getTodoById(
      createdTodoResult.asOk().value.id,
    );
    expect(result.asOk().value, isA<Todo>());
    expect(result.asOk().value.id, createdTodoResult.asOk().value.id);
  });
}
