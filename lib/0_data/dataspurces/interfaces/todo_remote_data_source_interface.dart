import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

abstract class ToDoRemoteDataSourceInterface {
  Future<ToDoEntryModel> getToDoEntry({
    required String userId,
    required CollectionId collectionId,
    required EntryId entryId,
  });

  Future<List<String>> getToDoEntryIds({
    required String userId,
    required String collectionId,
  });

  Future<ToDoCollectionModel> getToDoCollection({
    required String userId,
    required String collectionId,
  });

  Future<List<String>> getToDoCollectionsIds({
    required String userId,
  });

  Future<bool> createToDoEntry({
    required String userId,
    required String collectionId,
    required ToDoEntryModel entryModel,
  });

  Future<bool> createToDoCollection({
    required String userId,
    required ToDoCollectionModel collectionModel,
  });

  Future<ToDoEntryModel> updateToDoEntry({
    required String userId,
    required String collectionId,
    required ToDoEntryModel entryModel,
  });
}
