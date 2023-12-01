part of 'todo_detail_cubit.dart';

sealed class TodoDetailCubitState extends Equatable {
  const TodoDetailCubitState();

  @override
  List<Object> get props => [];
}

final class TodoDetailLoadeingState extends TodoDetailCubitState {}

final class TodoDetailLoadedState extends TodoDetailCubitState {
  final List<EntryId> entryIds;
  const TodoDetailLoadedState({required this.entryIds});
}

final class TodoDetailErrorState extends TodoDetailCubitState {}
