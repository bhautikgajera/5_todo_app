import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoCubitState> {
  NavigationTodoCubit() : super(const NavigationTodoCubitState());

  void selectedTodoCollectionChanged(
      {required isSecondBodyDisplayed, CollectionId? collectionId}) {
    emit(
      NavigationTodoCubitState(
          secondBodyIsDisplaied: isSecondBodyDisplayed,
          selectedCollectionId: collectionId),
    );
  }
}
