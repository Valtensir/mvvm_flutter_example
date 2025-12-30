import 'package:go_router/go_router.dart';
import 'package:mvvm_example/domain/use_cases/todo_update_use_case.dart';
import 'package:mvvm_example/routing/routes.dart';
import 'package:mvvm_example/ui/todo/widgets/todo_screen.dart';
import 'package:mvvm_example/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:mvvm_example/ui/todo_details/widgets/todo_details_screen.dart';

import '../data/repositories/todo/todo_repository_remote.dart';
import '../services/api/api_client.dart';
import '../ui/todo/viewmodels/todo_viewmodel.dart';

GoRouter routerConfig() {
  final todoRepository = TodoRepositoryRemote(
    apiClient: ApiClient(host: '192.168.1.14'),
  );

  final todoUpdateUseCase = TodoUpdateUseCase(todoRepository: todoRepository);
  return GoRouter(
    initialLocation: Routes.todos,
    routes: [
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(
            viewModel: TodoViewmodel(repository: todoRepository, todoUpdateUseCase: todoUpdateUseCase),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id']!;
              final viewModel = TodoDetailsViewmodel(
                todoRepository: todoRepository,
                todoUpdateUseCase: todoUpdateUseCase
              );
              viewModel.load.execute(todoId);
              
              return TodoDetailsScreen( viewmodel: viewModel);
            },
          ),
        ],
      ),
    ],
  );
}
