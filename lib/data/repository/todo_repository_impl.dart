import 'package:injectable/injectable.dart';
import 'package:todo_ai/model/todo.dart';
import 'package:todo_ai/data/service/hive_service.dart';
import 'package:todo_ai/data/repository/todo_repository.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final HiveService hiveService;

  TodoRepositoryImpl(this.hiveService);

  @override
  Future<void> addTodo(Todo todo) async {
    await hiveService.addTodo(todo);
  }

  @override
  Future<void> clearAll() async {
    await hiveService.clearAll();
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    return await hiveService.getAllTodos();
  }

  @override
  Future<void> removeTodo(String id) async {
    await hiveService.removeTodo(id);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await hiveService.updateTodo(todo);
  }
}
