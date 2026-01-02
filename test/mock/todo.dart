import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/models/todo/todo_api_model.dart';

const mockGetById = Todo(
  id: "1",
  name: "Primeiro",
  description: "Descrição",
  done: false,
);

const createTodoMock = CreateTodoApiModel(
  name: "Nome",
  description: "Descrição",
  done: false,
);

const addTodoMock = Todo(
  id: "1",
  name: "Nome",
  description: "Descrição",
  done: false,
);

final List<Todo> mockGetTodos = [
  const Todo(id: "1", name: "Nome", description: "Descrição", done: false),
  const Todo(
    id: "2",
    name: "Segundo",
    description: "Descrição do segundo",
    done: true,
  ),
];

const updateTodoMock = UpdateTodoApiModel(
  id: "1",
  name: "Nome alterado",
  description: "Descrição alterada",
  done: true,
);

const udpateTodoAlteradoMock = Todo(
  id: "1",
  name: "Nome alterado",
  description: "Descrição alterada",
  done: true,
);
