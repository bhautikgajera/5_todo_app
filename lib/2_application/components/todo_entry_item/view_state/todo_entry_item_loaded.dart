import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/2_application/components/todo_entry_item/block/todo_entry_item_cubit.dart';

class ToDoEntryItemLoaded extends StatelessWidget {
  const ToDoEntryItemLoaded({
    super.key,
    required this.todoEntry,
  });

  final TodoEntry todoEntry;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoEntryItemCubit>();
    return CheckboxListTile(
      value: todoEntry.isDone,
      title: Text(todoEntry.description),
      onChanged: (value) {
        cubit.update();
      },
    );
  }
}
