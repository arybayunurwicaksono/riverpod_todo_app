import 'package:go_router/go_router.dart';
import 'package:todo_ai/view/main_page.dart';
import 'package:todo_ai/view/todo_detail_page.dart';
import 'package:todo_ai/view/add_todo_page.dart';
import 'package:todo_ai/view/profile_page.dart';
import 'package:todo_ai/view/login_page.dart';
import 'package:todo_ai/view/register_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainPage()),
    GoRoute(path: '/add', builder: (context, state) => const AddTodoPage()),
    GoRoute(
      path: '/todo/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return TodoDetailPage(todoId: todoId);
      },
    ),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
