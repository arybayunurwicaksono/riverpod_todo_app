import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:riverpod_todo_app/model/todo.dart';
import 'package:riverpod_todo_app/service/hive_service.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  final HiveService hiveService;

  TodoNotifier(this.hiveService) : super([]) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await hiveService.getAllTodos();
    state = todos;
  }

  Future<void> addTodo(String title) async {
    final newTodo = Todo(id: Random().nextDouble().toString(), title: title);

    await hiveService.addTodo(newTodo);
    state = [...state, newTodo];
  }

  Future<void> removeTodo(String id) async {
    await hiveService.removeTodo(id);
    state = state.where((todo) => todo.id != id).toList();
  }

  Future<void> toggleTodo(String id) async {
    final updatedTodos = state.map((todo) {
      if (todo.id == id) {
        final updatedTodo = todo.copyWith(isDone: !todo.isDone);
        hiveService.updateTodo(updatedTodo);
        return updatedTodo;
      }
      return todo;
    }).toList();

    state = updatedTodos;
  }
}
