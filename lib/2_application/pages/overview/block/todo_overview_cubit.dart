import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collection.dart';
import 'package:todo_app/core/use_case.dart';

part './todo_overview_cubit_state.dart';

class TodoOverViewCubit extends Cubit<TodoOverViewCubitState> {
  final LoadTodoCollections loadTodoCollections;

  TodoOverViewCubit(
      {required this.loadTodoCollections, TodoOverViewCubitState? state})
      : super(state ?? TodoOverviewStateLoading());

  void getTodoCollections() async {
    emit(TodoOverviewStateLoading());

    final collectionFuture = loadTodoCollections.call(NoParams());

    final collection = await collectionFuture;

    collection.fold((left) {
      print("Error State >>>>>>>>>>>>>>>>>>>>>>>.${left}");
      emit(TodoOverviewStateError());
    }, (right) => emit(TodoOverviewStateLoaded(right)));
  }
}
