import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readTodoCollections();

  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId);

  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId);

  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId});

  Future<Either<Failure, bool>> createTodoCollection(ToDoCollection collection);
}
