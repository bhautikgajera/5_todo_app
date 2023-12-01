part of 'navigation_todo_cubit.dart';

class NavigationTodoCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? secondBodyIsDisplaied;

  const NavigationTodoCubitState(
      {this.secondBodyIsDisplaied, this.selectedCollectionId});

  @override
  List<Object?> get props => [selectedCollectionId, secondBodyIsDisplaied];
}
