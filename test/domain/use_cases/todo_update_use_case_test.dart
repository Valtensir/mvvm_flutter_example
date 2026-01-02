import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository.dart';
import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_example/utils/result/result.dart';

import '../../mock/todo.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

void main() {
  late TodoUpdateUseCase todoUpdateUseCase;
  late TodoRepository todoRepository;

  setUp(() {
    todoRepository = TodoRepositoryMock();
    todoUpdateUseCase = TodoUpdateUseCase(todoRepository: todoRepository);
  });

  group('UpdateTodoUseCase tests', () {
    test('update TODO returns Ok()', ()  async {
      when(() => todoRepository.update(updateTodoMockUseCase)).thenAnswer(
        (invocation) => Future.value(Result.ok(updateTodoMockUseCase)),
      );

      final result = await todoUpdateUseCase.updateTodo(updateTodoMockUseCase);
      expect(result, isA<Ok<Todo>>());
    });
    
    test('update TODO returns Error()', ()  async {
      when(() => todoRepository.update(updateTodoMockUseCase)).thenAnswer(
        (invocation) => Future.value(Result.error(Exception("Erro ao atualizar TODO"))),
      );

      final result = await todoUpdateUseCase.updateTodo(updateTodoMockUseCase);
      expect(result, isA<Error<Todo>>());
      expect(result.asError().error.toString(), "Exception: Erro ao atualizar TODO");
    });
  });
}
