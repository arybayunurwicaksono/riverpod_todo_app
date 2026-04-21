import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isDone;

  @HiveField(3)
  final DateTime? deadline;

  @HiveField(4)
  final String? description;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.deadline,
    this.description,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
    DateTime? deadline,
    String? description,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      deadline: deadline ?? this.deadline,
      description: description ?? this.description,
    );
  }
}
