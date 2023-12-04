import 'package:todo_app/0_data/dataspurces/interfaces/todo_locale_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exception.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class MomoryLocalDataSource implements ToDoLocalDataSourceInterface {
  final List<ToDoCollectionModel> todoCollections = [];

  final Map<String, List<ToDoEntryModel>> todoEntries = {};

  @override
  Future<bool> createToDoCollection(
      {required ToDoCollectionModel collectionModel}) {
    try {
      todoCollections.add(collectionModel);
      todoEntries.putIfAbsent(collectionModel.id, () => []);

      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createToDoEntry(
      {required String collectionId, required ToDoEntryModel entryModel}) {
    try {
      final doesCollectionExist = todoEntries.containsKey(collectionId);
      if (doesCollectionExist) {
        todoEntries[collectionId]?.add(entryModel);
        return Future.value(true);
      } else {
        // TODO(dev): add some error handling here
        return Future.value(false);
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) {
    try {
      final collection = todoCollections.firstWhere(
          (element) => element.id == collectionId,
          orElse: () => throw CollectionNotFoundException());

      return Future.value(collection);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoCollectionsIds() {
    try {
      return Future.value(
          todoCollections.map((collection) => collection.id).toList());
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required CollectionId collectionId, required EntryId entryId}) {
    try {
      if (todoEntries.containsKey(collectionId.value)) {
        final entry = todoEntries[collectionId.value]?.firstWhere(
            (element) => element.id == entryId.value,
            orElse: () => throw EntryNotFoundException());

        return Future.value(entry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoEntryIds({required String collectionId}) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        return Future.value(
            todoEntries[collectionId]?.map((entry) => entry.id).toList());
      } else {
        throw EntryNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (todoEntries.containsKey(collectionId)) {
        final entryIndex = todoEntries[collectionId]
            ?.indexWhere((element) => element.id == entryId);

        if (entryIndex == null || entryIndex == -1) {
          throw EntryNotFoundException();
        }
        final entry = todoEntries[collectionId]?[entryIndex];

        if (entry == null) {
          throw EntryNotFoundException();
        }
        final updatedEntry = ToDoEntryModel(
            id: entry.id,
            description: entry.description,
            isDone: !entry.isDone);

        todoEntries[collectionId]?[entryIndex] = updatedEntry;
        return Future.value(updatedEntry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
