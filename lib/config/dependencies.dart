import 'package:mvvm_example/data/repositories/todo/todo_repository_dev.dart';
import 'package:mvvm_example/data/repositories/todo/todo_repository_remote.dart';
import 'package:mvvm_example/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_example/services/api/api_client.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/todo/todo_repository.dart';

List<SingleChildWidget> get remoteProviders {
  return [
    Provider(create: (context) => ApiClient(host: '192.168.1.17')),
    ChangeNotifierProvider(
      create: (context) =>
          TodoRepositoryRemote(apiClient: context.read()) as TodoRepository,
    ),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get localProviders {
  return [
    ChangeNotifierProvider(
      create: (context) => TodoRepositoryDev() as TodoRepository,
    ),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get _sharedProviders {
  return [
    Provider(
      create: (context) => TodoUpdateUseCase(todoRepository: context.read()),
    ),
  ];
}
