import 'package:riverpod_todo_app/model/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAllTodos();
  Future<void> addTodo(Todo todo);
  Future<void> removeTodo(String id);
  Future<void> updateTodo(Todo todo);
  Future<void> clearAll();
}
