import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/0_data/mapper/todo_collection_mapper.dart';
import 'package:todo_app/0_data/mapper/todo_entry_mapper.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class ToDoRepositoryMixed
    with CollectionMapper, EntryMapper
    implements ToDoRepository {
  final ToDoRepository localeRepository;
  final ToDoRepository remoteRepository;

  ToDoRepositoryMixed(
      {required this.localeRepository, required this.remoteRepository});
  bool get isUserLoggedIn => userId != null;

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<Either<Failure, bool>> createTodoCollection(
      ToDoCollection collection) {
    if (isUserLoggedIn) {
      return remoteRepository.createTodoCollection(collection);
    } else {
      return localeRepository.createTodoCollection(collection);
    }
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(
      CollectionId collectionId, TodoEntry entry) {
    if (isUserLoggedIn) {
      return remoteRepository.createTodoEntry(collectionId, entry);
    } else {
      return localeRepository.createTodoEntry(collectionId, entry);
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readTodoCollections() {
    if (isUserLoggedIn) {
      return remoteRepository.readTodoCollections();
    } else {
      return localeRepository.readTodoCollections();
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId) {
    if (isUserLoggedIn) {
      return remoteRepository.readTodoEntry(collectionId, entryId);
    } else {
      return localeRepository.readTodoEntry(collectionId, entryId);
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId) {
    if (isUserLoggedIn) {
      return remoteRepository.readTodoEntryIds(collectionId);
    } else {
      return localeRepository.readTodoEntryIds(collectionId);
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required TodoEntry entry}) {
    if (isUserLoggedIn) {
      return remoteRepository.updateTodoEntry(
          collectionId: collectionId, entry: entry);
    } else {
      return localeRepository.updateTodoEntry(
          collectionId: collectionId, entry: entry);
    }
  }
}
