import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/model/todo.dart';
import 'package:riverpod_todo_app/model/todo_filter.dart';
import 'package:riverpod_todo_app/provider/todo_notifier.dart';
import 'package:riverpod_todo_app/injection.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return getIt<TodoNotifier>();
});

final filterProvider = StateProvider<TodoFilter>((ref) {
  return TodoFilter.all;
});

final filteredTodoProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoProvider);
  final filter = ref.watch(filterProvider);

  return switch (filter) {
    TodoFilter.active => todos.where((t) => !t.isDone).toList(),
    TodoFilter.completed => todos.where((t) => t.isDone).toList(),
    TodoFilter.overdue =>
      todos
          .where(
            (t) =>
                !t.isDone &&
                t.deadline != null &&
                t.deadline!.isBefore(DateTime.now()),
          )
          .toList(),
    TodoFilter.all => todos,
  };
});

final totalTodoProvider = Provider<int>((ref) {
  return ref.watch(todoProvider).length;
});

final completedTodoProvider = Provider<int>((ref) {
  return ref.watch(todoProvider).where((t) => t.isDone).length;
});
