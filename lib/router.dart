import 'package:go_router/go_router.dart';
import 'package:riverpod_todo_app/view/home_page.dart';
import 'package:riverpod_todo_app/view/todo_detail_page.dart';
import 'package:riverpod_todo_app/view/add_todo_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/add', builder: (context, state) => const AddTodoPage()),
    GoRoute(
      path: '/todo/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return TodoDetailPage(todoId: todoId);
      },
    ),
  ],
);
