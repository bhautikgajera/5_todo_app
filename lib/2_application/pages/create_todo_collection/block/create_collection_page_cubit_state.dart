part of 'create_collection_page_cubit.dart';

class CreateCollectionCubitState extends Equatable {
  final String? title;
  final String? color;

  const CreateCollectionCubitState({this.title, this.color});

  CreateCollectionCubitState copyWith({String? title, String? color}) {
    return CreateCollectionCubitState(
        title: title ?? this.title, color: color ?? this.color);
  }

  @override
  List<Object?> get props => [title, color];
}
