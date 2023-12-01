import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part './todo_entry_item_cubit_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemCubitState> {
  TodoEntryItemCubit(
      {required this.entryId,
      required this.collectionId,
      required this.loadTodoEntry,
      required this.updateTodoEntry})
      : super(TodoEntryItemLoadingState());

  final EntryId entryId;

  final CollectionId collectionId;

  final LoadTodoEntry loadTodoEntry;

  final UpdateTodoEntry updateTodoEntry;

  Future<void> fetch() async {
    emit(TodoEntryItemLoadingState());

    try {
      final entry = await loadTodoEntry.call(
          TodoEntryIdsParam(entryId: entryId, collectionId: collectionId));

      return entry.fold((left) {
        emit(TodoEntryItemErrorState());
      }, (right) {
        emit(TodoEntryItemLoadedState(todoEntry: right));
      });
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }

  void update() async {
    emit(TodoEntryItemLoadingState());
    final result = await updateTodoEntry
        .call(TodoEntryIdsParam(entryId: entryId, collectionId: collectionId));

    result.fold((left) => emit(TodoEntryItemErrorState()),
        (right) => emit(TodoEntryItemLoadedState(todoEntry: right)));
  }
}
