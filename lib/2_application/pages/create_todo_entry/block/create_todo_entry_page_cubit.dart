import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/form_value.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_todo_entry_page_cubit_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageCubitState> {
  CreateTodoEntryPageCubit(
      {required this.collectionId, required this.createTodoEntry})
      : super(const CreateTodoEntryPageCubitState());

  final CollectionId collectionId;

  final CreateTodoEntry createTodoEntry;

  void descriptionChanged(String? description) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    // could do more complex validation, like call your backend and so on
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
      emit(state.copyWith(
          description:
              FormValue(value: description, validationStatus: currentStatus)));
    }
  }

  void submit(BuildContext context) async {
    final result = await createTodoEntry.call(CreateEntryParams(
        collectionId: collectionId,
        entry:
            TodoEntry.empty().copyWith(description: state.description?.value)));

    result.fold((left) => print(left), (right) => context.pop());
  }
}
