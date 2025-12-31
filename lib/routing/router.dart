import 'package:go_router/go_router.dart';
import 'package:mvvm_example/routing/routes.dart';
import 'package:mvvm_example/ui/todo/widgets/todo_screen.dart';
import 'package:mvvm_example/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:mvvm_example/ui/todo_details/widgets/todo_details_screen.dart';
import 'package:provider/provider.dart';

import '../ui/todo/viewmodels/todo_viewmodel.dart';

GoRouter routerConfig() {
  return GoRouter(
    initialLocation: Routes.todos,
    routes: [
      GoRoute(
        path: Routes.todos,
        builder: (context, state) {
          return TodoScreen(
            viewModel: TodoViewmodel(
              repository: context.read(),
              todoUpdateUseCase: context.read(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final todoId = state.pathParameters['id']!;
              final viewModel = TodoDetailsViewmodel(
                todoRepository: context.read(),
                todoUpdateUseCase: context.read(),
              );
              viewModel.load.execute(todoId);

              return TodoDetailsScreen(viewmodel: viewModel);
            },
          ),
        ],
      ),
    ],
  );
}
