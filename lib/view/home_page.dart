import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_ai/model/todo_filter.dart';
import 'package:todo_ai/provider/todo_provider.dart';
import 'package:todo_ai/view/widget/animated_todo_item.dart';
import 'package:todo_ai/view/widget/gemini_suggestion_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodoProvider);
    final total = ref.watch(totalTodoProvider);
    final completed = ref.watch(completedTodoProvider);
    final filter = ref.watch(filterProvider);

    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryItem('Total', total),
                _summaryItem('Done', completed),
                _summaryItem('Active', total - completed),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              _filterChip(ref, TodoFilter.all, filter, 'All'),
              _filterChip(ref, TodoFilter.active, filter, 'Active'),
              _filterChip(ref, TodoFilter.completed, filter, 'Done'),
              _filterChip(ref, TodoFilter.overdue, filter, 'Late'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const GeminiSuggestionCard(),
        const SizedBox(height: 8),
        Expanded(
          child: todos.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list_alt, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No todos found',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return AnimatedTodoItem(todo: todo);
                  },
                ),
        ),
      ],
    );
  }

  Widget _summaryItem(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _filterChip(
    WidgetRef ref,
    TodoFilter value,
    TodoFilter current,
    String label,
  ) {
    final isSelected = value == current;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
        selected: isSelected,
        checkmarkColor: Colors.white,
        selectedColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: (_) {
          ref.read(filterProvider.notifier).state = value;
        },
      ),
    );
  }
}
