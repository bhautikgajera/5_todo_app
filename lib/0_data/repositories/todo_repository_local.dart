import 'package:either_dart/either.dart';
import 'package:todo_app/0_data/dataspurces/interfaces/todo_locale_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exception.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class ToDoRepositoryLocal extends ToDoRepository {
  final ToDoLocalDataSourceInterface localDataSource;

  ToDoRepositoryLocal({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> createTodoCollection(
      ToDoCollection collection) async {
    try {
      final result = await localDataSource.createToDoCollection(
          collectionModel: ToDoCollectionModel(
              id: collection.id.value,
              title: collection.title,
              colorIndex: collection.color.colorIndex));

      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(stackTrace: e.toString()));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(
      CollectionId collectionId, TodoEntry entry) async {
    try {
      final result = await localDataSource.createToDoEntry(
          collectionId: collectionId.value,
          entryModel: todoEntryToModel(entry));
      return Right(result);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readTodoCollections() async {
    try {
      final collectionIds = await localDataSource.getToDoCollectionsIds();
      final List<ToDoCollection> collections = [];
      for (var data in collectionIds) {
        final collectionModel =
            await localDataSource.getToDoCollection(collectionId: data);
        collections.add(todoCollectionModelToEntity(collectionModel));
      }
      return Right(collections);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final result = await localDataSource.getToDoEntry(
          collectionId: collectionId, entryId: entryId);

      return Right(todoModelToEntity(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId) async {
    try {
      final result = await localDataSource.getToDoEntryIds(
          collectionId: collectionId.value);
      return Right(result
          .map((entryIds) => EntryId.fromUniqueString(entryIds))
          .toList());
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId}) async {
    try {
      final result = await localDataSource.updateToDoEntry(
          collectionId: collectionId.value, entryId: entryId.value);
      return Right(todoModelToEntity(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}

ToDoEntryModel todoEntryToModel(TodoEntry entry) {
  return ToDoEntryModel(
      id: entry.id.value, description: entry.description, isDone: entry.isDone);
}

ToDoCollectionModel todoCollectionToModel(ToDoCollection collection) {
  return ToDoCollectionModel(
      id: collection.id.value,
      title: collection.title,
      colorIndex: collection.color.colorIndex);
}

TodoEntry todoModelToEntity(ToDoEntryModel entry) {
  return TodoEntry(
      id: EntryId.fromUniqueString(entry.id),
      description: entry.description,
      isDone: entry.isDone);
}

ToDoCollection todoCollectionModelToEntity(ToDoCollectionModel collection) {
  return ToDoCollection(
      id: CollectionId.fromUniqueString(collection.id),
      title: collection.title,
      color: ToDoColor(colorIndex: collection.colorIndex));
}
