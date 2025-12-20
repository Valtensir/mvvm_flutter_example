import 'dart:convert';
import 'dart:io';

import 'package:mvvm_example/domain/models/todo.dart';
import 'package:mvvm_example/services/api/models/todo/todo_api_model.dart';
import 'package:mvvm_example/utils/result/result.dart';

class ApiClient {
  ApiClient({String? host, int? port, HttpClient Function()? httpClientFactory})
    : _host = host ?? "192.168.0.69",
      _port = port ?? 3000,
      _httpClientFactory = httpClientFactory ?? (() => HttpClient());

  final String _host;
  final int _port;
  final HttpClient Function() _httpClientFactory;

  Future<Result<List<Todo>>> getTodos() async {
    final client = _httpClientFactory();
    try {
      final request = await client.get(_host, _port, "/todos");
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final List<dynamic> jsonData = jsonDecode(stringData) as List<dynamic>;
        final todos = jsonData
            .map((jsonItem) => Todo.fromJson(jsonItem as Map<String, dynamic>))
            .toList();

        return Result.ok(todos);
      } else {
        return Result.error(const HttpException("Failed to load todos"));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<Todo>> createTodo(CreateTodoApiModel todo) async {
    final client = _httpClientFactory();
    try {
      final request = await client.post(_host, _port, "/todos");
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      final body = jsonEncode(todo.toJson());
      request.add(utf8.encode(body));

      final response = await request.close();

      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> jsonData =
            jsonDecode(stringData) as Map<String, dynamic>;
        final todo = Todo.fromJson(jsonData);

        return Result.ok(todo);
      } else {
        return Result.error(const HttpException("Failed to create todo"));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<Todo>> udpateTodo(UpdateTodoApiModel todo) async {
    final client = _httpClientFactory();
    try {
      final request = await client.put(_host, _port, "/todos/${todo.id}");
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
      final body = jsonEncode(todo.toJson());
      request.add(utf8.encode(body));

      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> jsonData =
            jsonDecode(stringData) as Map<String, dynamic>;
        final todo = Todo.fromJson(jsonData);

        return Result.ok(todo);
      } else {
        return Result.error(const HttpException("Failed to update todo"));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<Todo>> deleteTodo(Todo todo) async {
    final client = _httpClientFactory();
    try {
      final request = await client.delete(_host, _port, "/todos/${todo.id}");
      final response = await request.close();

      if (response.statusCode == 200) {
        return Result.ok(todo);
      } else {
        return Result.error(const HttpException("Failed to delete todo"));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }

  Future<Result<Todo>> getTodoById(String id) async {
    final client = _httpClientFactory();
    try {
      final request = await client.get(_host, _port, "/todos/$id");
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");

      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> jsonData =
            jsonDecode(stringData) as Map<String, dynamic>;
        final todo = Todo.fromJson(jsonData);

        return Result.ok(todo);
      } else {
        return Result.error(const HttpException("Failed to update todo"));
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      client.close();
    }
  }
}
