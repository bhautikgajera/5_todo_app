import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';

class ToDOOverviewLoaded extends StatelessWidget {
  const ToDOOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          return ListTile(
            onTap: () => print("Item => ${item.title}"),
            tileColor: colorScheme.surface,
            selectedTileColor: colorScheme.surfaceVariant,
            iconColor: item.color.color,
            selectedColor: item.color.color,
            leading: const Icon(Icons.circle),
          );
        });
  }
}
