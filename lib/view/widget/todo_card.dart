import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/provider/todo_provider.dart';

class TodoCard extends ConsumerWidget {
  final dynamic todo;
  final VoidCallback onDelete;

  const TodoCard({required this.todo, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withValues(alpha: 0.05)),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: todo.isDone,
            activeColor: Colors.blue,
            onChanged: (_) {
              ref.read(todoProvider.notifier).toggleTodo(todo.id);
            },
          ),
          Expanded(
            child: Text(
              todo.title,
              style: TextStyle(
                fontSize: 16,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                color: todo.isDone ? Colors.grey : Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
