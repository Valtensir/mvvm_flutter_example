import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository_remote.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:mvvm_example/utils/result/result.dart';

import '../../../mock/todo.dart';

class MocKApiClient extends Mock implements ApiClient {}

void main() {
  late TodoRepositoryRemote todoRepository;
  late ApiClient apiClient;

  setUp(() {
    apiClient = MocKApiClient();
    todoRepository = TodoRepositoryRemote(apiClient: apiClient);
  });

  group("TodoRepositoryRemote tests", () {
    test("Should get a TODO by id", () async {
      when(
        () => apiClient.getTodoById(any()),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetById)));

      final result = await todoRepository.getTodoById("1");

      expect(result, isA<Ok<Todo>>());
      expect(result.asOk().value.id, "1");
      expect(result.asOk().value.name, "Primeiro");
      expect(result.asOk().value.description, "Descrição");
      expect(result.asOk().value.done, false);

      final result2 = await todoRepository.getTodoById("1");

      expect(result2, isA<Ok<Todo>>());
      expect(result2.asOk().value.id, "1");
      expect(result2.asOk().value.name, "Primeiro");
      expect(result2.asOk().value.description, "Descrição");
      expect(result2.asOk().value.done, false);

      verify(() => apiClient.getTodoById(any())).called(1);
    });

    test("add TODO", () async {
      when(
        () => apiClient.createTodo(createTodoMock),
      ).thenAnswer((invocation) => Future.value(Result.ok(addTodoMock)));

      bool wasNotified = false;

      todoRepository.addListener(() {
        wasNotified = true;
      });

      final result = await todoRepository.add(
        name: "Nome",
        description: "Descrição",
        done: false,
      );

      final createdTodo = result.asOk().value;

      expect(result, isA<Ok<Todo>>());

      expect(todoRepository.todos.contains(addTodoMock), isTrue);

      expect(createdTodo.id, '1');
      expect(createdTodo.name, 'Nome');
      expect(createdTodo.description, 'Descrição');
      expect(createdTodo.done, false);

      expect(wasNotified, true);
    });

    test('delete TODO', () async {
      when(
        () => apiClient.deleteTodo(addTodoMock),
      ).thenAnswer((invocation) => Future.value(Result.ok(addTodoMock)));

      when(
        () => apiClient.getTodos(),
      ).thenAnswer((invocation) => Future.value(Result.ok([addTodoMock])));

      final result = await todoRepository.get();

      expect(result, isA<Ok<List<Todo>>>());
      expect(todoRepository.todos.contains(addTodoMock), isTrue);

      bool wasNotified = false;

      todoRepository.addListener(() {
        wasNotified = true;
      });

      final deleteResult = await todoRepository.delete(
        todoRepository.todos.first,
      );

      expect(deleteResult, isA<Ok<Todo>>());
      expect(todoRepository.todos.contains(addTodoMock), isFalse);
      expect(wasNotified, isTrue);
    });

    test('Update TODO', () async {
      when(
        () => apiClient.getTodos(),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetTodos)));

      when(() => apiClient.udpateTodo(updateTodoMock)).thenAnswer(
        (invocation) => Future.value(Result.ok(udpateTodoAlteradoMock)),
      );

      final result = await todoRepository.get();

      expect(result, isA<Ok<List<Todo>>>());

      final todos = result.asOk().value;

      bool wasNotified = false;

      todoRepository.addListener(() => wasNotified = true);

      final updateTodoResult = await todoRepository.update(
        todos.first.copyWith(
          name: "Nome alterado",
          description: "Descrição alterada",
          done: true,
        ),
      );

      expect(updateTodoResult, isA<Ok<Todo>>());

      final updatedTodo = updateTodoResult.asOk().value;
      expect(updatedTodo.id, "1");
      expect(updatedTodo.name, "Nome alterado");
      expect(updatedTodo.description, "Descrição alterada");
      expect(updatedTodo.done, isTrue);

      expect(todoRepository.todos.contains(updatedTodo), isTrue);
      expect(wasNotified, isTrue);
    });

    test('get TODOs', () async {
      when(
        () => apiClient.getTodos(),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetTodos)));

      bool wasNotified = false;
      todoRepository.addListener(() => wasNotified = true);
      final result = await todoRepository.get();

      expect(result, isA<Ok<List<Todo>>>());
      expect(todoRepository.todos.length, 2);
      expect(todoRepository.todos, equals(mockGetTodos));
      expect(wasNotified, isTrue);
    });
  });
}
