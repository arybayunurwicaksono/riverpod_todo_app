import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'dart:math';

import 'package:todo_ai/model/todo.dart';
import 'package:todo_ai/data/repository/todo_repository.dart';

@injectable
class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoRepository todoRepository;

  TodoNotifier(this.todoRepository) : super([]) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await todoRepository.getAllTodos();
    state = todos;
  }

  Future<void> addTodo(
    String title, {
    DateTime? deadline,
    String? description,
  }) async {
    final newTodo = Todo(
      id: Random().nextDouble().toString(),
      title: title,
      deadline: deadline,
      description: description,
    );

    await todoRepository.addTodo(newTodo);
    state = [...state, newTodo];
  }

  Future<void> removeTodo(String id) async {
    await todoRepository.removeTodo(id);
    state = state.where((todo) => todo.id != id).toList();
  }

  Future<void> toggleTodo(String id) async {
    final updatedTodos = state.map((todo) {
      if (todo.id == id) {
        final updatedTodo = todo.copyWith(isDone: !todo.isDone);
        todoRepository.updateTodo(updatedTodo);
        return updatedTodo;
      }
      return todo;
    }).toList();

    state = updatedTodos;
  }
}
