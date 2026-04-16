import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_todo_app/model/todo.dart';

class HiveService {
  static const String boxName = 'todos';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>(boxName);
  }

  static Box<Todo> getBox() {
    return Hive.box<Todo>(boxName);
  }

  Future<List<Todo>> getAllTodos() async {
    final box = getBox();
    return box.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    final box = getBox();
    await box.put(todo.id, todo);
  }

  Future<void> removeTodo(String id) async {
    final box = getBox();
    await box.delete(id);
  }

  Future<void> updateTodo(Todo todo) async {
    final box = getBox();
    await box.put(todo.id, todo);
  }

  Future<void> clearAll() async {
    final box = getBox();
    await box.clear();
  }
}
