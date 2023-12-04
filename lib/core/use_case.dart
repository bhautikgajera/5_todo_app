import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class TodoEntryIdsParam extends Params {
  final EntryId entryId;

  final CollectionId collectionId;

  TodoEntryIdsParam({required this.entryId, required this.collectionId})
      : super();

  @override
  List<Object?> get props => [collectionId, entryId];
}

class CollectionIdParam extends Params {
  final CollectionId collectionId;

  CollectionIdParam({required this.collectionId});

  @override
  List<Object?> get props => [collectionId];
}

class CreateCollectionParam extends Params {
  CreateCollectionParam({required this.collection}) : super();
  final ToDoCollection collection;

  @override
  List<Object?> get props => [collection];
}

class CreateEntryParams extends Params {
  final TodoEntry entry;
  final CollectionId collectionId;

  CreateEntryParams({required this.entry, required this.collectionId})
      : super();

  @override
  List<Object?> get props => [entry, collectionId];
}
