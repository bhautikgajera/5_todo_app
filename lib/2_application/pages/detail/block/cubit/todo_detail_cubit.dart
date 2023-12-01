import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_detail_state.dart';

class TodoDetailCubit extends Cubit<TodoDetailCubitState> {
  TodoDetailCubit(
      {required this.collectionId, required this.loadTodoEntryIdsForCollection})
      : super(TodoDetailLoadeingState());

  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(TodoDetailLoadeingState());

    try {
      final entryIds = await loadTodoEntryIdsForCollection
          .call(CollectionIdParam(collectionId: collectionId));

      if (entryIds.isLeft) {
        emit(TodoDetailErrorState());
      }
      if (entryIds.isRight) {
        emit(TodoDetailLoadedState(entryIds: entryIds.right));
      }
    } on Exception {
      emit(TodoDetailErrorState());
    }
  }
}
