import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_ai/model/todo.dart';
import 'package:todo_ai/model/todo_filter.dart';
import 'package:todo_ai/provider/todo_notifier.dart';
import 'package:todo_ai/data/service/gemini_service.dart';
import 'package:todo_ai/injection.dart';
import 'dart:math';

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

// Provider untuk todo yang belum selesai
final incompleteTodosProvider = Provider<List<Todo>>((ref) {
  return ref.watch(todoProvider).where((t) => !t.isDone).toList();
});

// Provider untuk random incomplete todo dengan suggestion
final randomIncompleteTodoProvider = FutureProvider<Map<String, dynamic>?>((
  ref,
) async {
  final incompleteTodos = ref.watch(incompleteTodosProvider);

  if (incompleteTodos.isEmpty) {
    return null;
  }

  // Pilih todo secara random
  final random = Random();
  final randomTodo = incompleteTodos[random.nextInt(incompleteTodos.length)];

  // Generate suggestion menggunakan Gemini
  final geminiService = getIt.get<GeminiService>();
  final suggestion = await geminiService.generateTodoSuggestion(randomTodo);

  return {'todo': randomTodo, 'suggestion': suggestion};
});

// Provider untuk suggestion card yang lebih komprehensif
final suggestionCardProvider = FutureProvider<Map<String, dynamic>?>((
  ref,
) async {
  final todos = ref.watch(todoProvider);
  final incompleteTodos = ref.watch(incompleteTodosProvider);
  final completed = ref.watch(completedTodoProvider);
  final geminiService = getIt.get<GeminiService>();

  // Jika tidak ada todo sama sekali
  if (todos.isEmpty) {
    final invitation = await geminiService.generateCreateTodoInvitation();
    return {'type': 'no_todos', 'message': invitation};
  }

  // Jika semua todo sudah selesai
  if (incompleteTodos.isEmpty && todos.isNotEmpty) {
    final congratulation = await geminiService.generateCompletionMessage(
      completed,
      todos.length,
    );
    return {
      'type': 'all_completed',
      'totalCompleted': completed,
      'totalTodos': todos.length,
      'message': congratulation,
    };
  }

  // Jika masih ada todo yang belum selesai
  if (incompleteTodos.isNotEmpty) {
    final random = Random();
    final randomTodo = incompleteTodos[random.nextInt(incompleteTodos.length)];

    final suggestion = await geminiService.generateTodoSuggestion(randomTodo);

    return {
      'type': 'incomplete_reminder',
      'todo': randomTodo,
      'suggestion': suggestion,
    };
  }

  return null;
});
