part of "./todo_entry_item_cubit.dart";

abstract class TodoEntryItemCubitState extends Equatable {
  const TodoEntryItemCubitState();

  @override
  List<Object?> get props => [];
}

class TodoEntryItemLoadedState extends TodoEntryItemCubitState {
  final TodoEntry todoEntry;

  const TodoEntryItemLoadedState({required this.todoEntry});

  @override
  List<Object?> get props => [todoEntry];
}

class TodoEntryItemErrorState extends TodoEntryItemCubitState {}

class TodoEntryItemLoadingState extends TodoEntryItemCubitState {}
