import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/2_application/components/todo_entry_item/block/todo_entry_item_cubit.dart';

import 'view_state/todo_entry_item_error.dart';
import 'view_state/todo_entry_item_loaded.dart';
import 'view_state/todo_entry_item_loading.dart';

class TodoEntryItemProvider extends StatelessWidget {
  const TodoEntryItemProvider(
      {super.key, required this.collectionId, required this.entryId});

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<ToDoRepository>(context);
    return BlocProvider<TodoEntryItemCubit>(
      create: (context) => TodoEntryItemCubit(
          collectionId: collectionId,
          entryId: entryId,
          updateTodoEntry: UpdateTodoEntry(toDoRepository: repository),
          loadTodoEntry: LoadTodoEntry(toDoRepository: repository)),
      child: const TodoEntryItem(),
    );
  }
}

class TodoEntryItem extends StatelessWidget {
  const TodoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemCubitState>(
      builder: (context, state) {
        if (state is TodoEntryItemLoadingState) {
          return const ToDoEntryItemLoading();
        } else if (state is TodoEntryItemLoadedState) {
          return ToDoEntryItemLoaded(
            todoEntry: state.todoEntry,
          );
        } else if (state is TodoEntryItemErrorState) {
          return const ToDoEntryItemError();
        }
        return const Placeholder();
      },
    );
  }
}
