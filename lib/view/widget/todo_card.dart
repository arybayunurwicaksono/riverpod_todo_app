import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo_app/provider/todo_provider.dart';

class TodoCard extends ConsumerWidget {
  final dynamic todo;
  final VoidCallback onDelete;

  const TodoCard({required this.todo, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLate =
        todo.deadline != null &&
        !todo.isDone &&
        todo.deadline!.isBefore(DateTime.now());
    final deadlineText = todo.deadline != null
        ? '${todo.deadline!.year}-${todo.deadline!.month.toString().padLeft(2, '0')}-${todo.deadline!.day.toString().padLeft(2, '0')}'
        : null;

    return GestureDetector(
      onTap: () {
        // Navigate to detail page
        context.push('/todo/${todo.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black.withValues(alpha: 0.05),
            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: todo.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                  if (deadlineText != null) const SizedBox(height: 4),
                  if (deadlineText != null)
                    Row(
                      children: [
                        Text(
                          'Due $deadlineText',
                          style: TextStyle(
                            fontSize: 12,
                            color: isLate ? Colors.red : Colors.grey[600],
                          ),
                        ),
                        if (isLate)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Late',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
