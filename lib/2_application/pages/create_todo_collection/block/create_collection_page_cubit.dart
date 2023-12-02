import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_collection_page_cubit_state.dart';

class CreateCollectionCubit extends Cubit<CreateCollectionCubitState> {
  final CreateTodoCollection createTodoCollection;

  CreateCollectionCubit({required this.createTodoCollection})
      : super(const CreateCollectionCubitState());

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  void submit(BuildContext context) async {
    final parsedColorIndex = int.tryParse(state.color ?? "") ?? 0;
    final result = await createTodoCollection.call(
      CreateCollectionParam(
        collection: ToDoCollection.empty().copyWith(
          title: state.title,
          color: ToDoColor(colorIndex: parsedColorIndex),
        ),
      ),
    );
    result.fold((left) => print("Error >>>> $left"), (right) => context.pop());
  }
}
