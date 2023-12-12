import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/0_data/dataspurces/interfaces/todo_remote_data_source_interface.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class FireStoreDataImpl implements ToDoRemoteDataSourceInterface {
  final fireStore = FirebaseFirestore.instance;
  @override
  Future<bool> createToDoCollection(
      {required String userId,
      required ToDoCollectionModel collectionModel}) async {
    return await fireStore
        .collection(userId)
        .doc(collectionModel.id)
        .set(collectionModel.toJson())
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  Future<bool> createToDoEntry(
      {required String userId,
      required String collectionId,
      required ToDoEntryModel entryModel}) async {
    final result = await fireStore
        .collection(userId)
        .doc(collectionId)
        .collection("todo-entries")
        .doc(entryModel.id)
        .set(entryModel.toJson())
        .then((value) => true)
        .catchError((onError) => false);
    return result;
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String userId, required String collectionId}) async {
    final collectionRef = fireStore.collection(userId);

    final docRef = collectionRef.doc(collectionId);
    final docs = await docRef.get();

    if (docs.exists || docs.data() != null) {
      return ToDoCollectionModel.fromJson(docs.data()!);
    } else {
      throw Exception("Document Not Exist");
    }
  }

  @override
  Future<List<String>> getToDoCollectionsIds({required String userId}) async {
    final collectionRef = fireStore.collection(userId);

    final quarySnapshot = await collectionRef.get();

    return quarySnapshot.docs.map((e) {
      return e.id;
    }).toList();
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String userId,
      required CollectionId collectionId,
      required EntryId entryId}) async {
    final documentSnapShot = await fireStore
        .collection(userId)
        .doc(collectionId.value)
        .collection("todo-entries")
        .doc(entryId.value)
        .get();

    if (documentSnapShot.exists && documentSnapShot.data() != null) {
      return ToDoEntryModel.fromJson(documentSnapShot.data()!);
    }
    throw Exception("Entry Not Found");
  }

  @override
  Future<List<String>> getToDoEntryIds(
      {required String userId, required String collectionId}) async {
    final querySnapShot = await fireStore
        .collection(userId)
        .doc(collectionId)
        .collection("todo-entries")
        .get();

    return querySnapShot.docs.map((entry) => entry.id).toList();
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String userId,
      required String collectionId,
      required ToDoEntryModel entryModel}) async {
    final updatedModel = ToDoEntryModel(
        id: entryModel.id,
        description: entryModel.description,
        isDone: !entryModel.isDone);
    final result = await fireStore
        .collection(userId)
        .doc(collectionId)
        .collection("todo-entries")
        .doc(entryModel.id)
        .set(updatedModel.toJson(), SetOptions(merge: true));

    return updatedModel;
  }
}
