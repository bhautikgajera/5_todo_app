part of 'create_todo_entry_page_cubit.dart';

class CreateTodoEntryPageCubitState extends Equatable {
  const CreateTodoEntryPageCubitState({this.description});
  final FormValue<String?>? description;

  CreateTodoEntryPageCubitState copyWith({FormValue<String?>? description}) {
    return CreateTodoEntryPageCubitState(
        description: description ?? this.description);
  }

  @override
  List<Object?> get props => [description];
}
