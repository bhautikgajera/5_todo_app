import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

abstract class ToDoLocalDataSourceInterface {
  Future<ToDoEntryModel> getToDoEntry(
      {required CollectionId collectionId, required EntryId entryId});

  Future<List<String>> getToDoEntryIds({required String collectionId});

  Future<ToDoCollectionModel> getToDoCollection({required String collectionId});

  Future<List<String>> getToDoCollectionsIds();

  Future<bool> createToDoEntry(
      {required String collectionId, required ToDoEntryModel entryModel});

  Future<bool> createToDoCollection(
      {required ToDoCollectionModel collectionModel});

  Future<ToDoEntryModel> updateToDoEntry({
    required String collectionId,
    required String entryId,
  });
}
