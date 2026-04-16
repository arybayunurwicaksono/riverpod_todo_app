import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/model/todo_filter.dart';
import 'package:riverpod_todo_app/provider/todo_provider.dart';
import 'package:riverpod_todo_app/view/widget/animated_todo_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodoProvider);
    final total = ref.watch(totalTodoProvider);
    final completed = ref.watch(completedTodoProvider);
    final filter = ref.watch(filterProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
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
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return AnimatedTodoItem(todo: todo);
              },
            ),
          ),

          const _InputField(),
        ],
      ),
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
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: (_) {
          ref.read(filterProvider.notifier).state = value;
        },
      ),
    );
  }
}

class _InputField extends ConsumerStatefulWidget {
  const _InputField();

  @override
  ConsumerState<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends ConsumerState<_InputField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Add new todo...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ref.read(todoProvider.notifier).addTodo(controller.text);

                  controller.clear();
                }
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
