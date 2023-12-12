import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/0_data/dataspurces/interfaces/todo_locale_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exception.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class HiveLocaleDataSource implements ToDoLocalDataSourceInterface {
  HiveLocaleDataSource();
  late BoxCollection toDoCollection;

  bool isInitialize = false;

  Future<void> init() async {
    if (!isInitialize) {
      toDoCollection =
          await BoxCollection.open("todo", {"collection", "entry"}, path: "./");
      isInitialize = true;
    } else {
      debugPrint("Hive Was Already Initialized!");
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    await init();
    return toDoCollection.openBox<Map>("collection");
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    await init();
    return toDoCollection.openBox<Map>("entry");
  }

  @override
  Future<bool> createToDoCollection(
      {required ToDoCollectionModel collectionModel}) async {
    final collectionBox = await _openCollectionBox();
    final entryBox = await _openEntryBox();
    collectionBox.put(collectionModel.id, collectionModel.toJson());
    entryBox.put(collectionModel.id, {});
    return true;
  }

  @override
  Future<bool> createToDoEntry(
      {required String collectionId,
      required ToDoEntryModel entryModel}) async {
    final entryBox = await _openEntryBox();

    final entryList = await entryBox.get(collectionId);
    if (entryList == null) throw CollectionNotFoundException();
    entryList
        .cast<String, dynamic>()
        .putIfAbsent(entryModel.id, () => entryModel.toJson());

    await entryBox.put(collectionId, entryList);
    return true;
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) async {
    final collectionBox = await _openCollectionBox();

    final collection = await collectionBox.get(collectionId);

    if (collection == null) throw CollectionNotFoundException();

    return ToDoCollectionModel.fromJson(collection.cast<String, dynamic>());
  }

  @override
  Future<List<String>> getToDoCollectionsIds() async {
    final collectionBox = await _openCollectionBox();

    final list = await collectionBox.getAllKeys();

    return list;
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required CollectionId collectionId, required EntryId entryId}) async {
    final entryBox = await _openEntryBox();

    final entryList = await entryBox.get(collectionId.value);

    if (entryList == null) throw CollectionNotFoundException();

    final entry = entryList[entryId.value];
    if (entry == null) throw EntryNotFoundException();

    return ToDoEntryModel.fromJson(entry);
  }

  @override
  Future<List<String>> getToDoEntryIds({required String collectionId}) async {
    final entryBox = await _openEntryBox();

    final entryList = await entryBox.get(collectionId);

    if (entryList == null) throw CollectionNotFoundException();

    final entryIdList = entryList.keys.cast<String>().toList();

    return entryIdList;
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) async {
    final entryBox = await _openEntryBox();

    final entryList = await entryBox.get(collectionId);

    if (entryList == null) throw CollectionNotFoundException();

    final entry = entryList[entryId];
    final entryModel = ToDoEntryModel.fromJson(entry);
    final updatedEntry = ToDoEntryModel(
        id: entryModel.id,
        description: entryModel.description,
        isDone: !entryModel.isDone);
    entryList[entryId] = updatedEntry.toJson();
    entryBox.put(collectionId, entryList);
    return updatedEntry;
  }
}
