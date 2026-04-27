import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_ai/provider/todo_provider.dart';
import 'package:todo_ai/view/widget/todo_card.dart';

class AnimatedTodoItem extends ConsumerWidget {
  final dynamic todo;

  const AnimatedTodoItem({required this.todo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TodoCard(
      todo: todo,
      onDelete: () {
        ref.read(todoProvider.notifier).removeTodo(todo.id);
      },
    );
  }
}
