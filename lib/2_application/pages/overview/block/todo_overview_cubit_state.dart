part of './todo_overview_cubit.dart';

abstract class TodoOverViewCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoOverviewStateLoading extends TodoOverViewCubitState {}

class TodoOverviewStateError extends TodoOverViewCubitState {}

class TodoOverviewStateLoaded extends TodoOverViewCubitState {
  final List<ToDoCollection> collection;

  TodoOverviewStateLoaded(this.collection);

  @override
  List<Object?> get props => [collection];
}
