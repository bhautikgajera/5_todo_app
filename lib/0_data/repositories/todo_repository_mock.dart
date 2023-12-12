import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements ToDoRepository {
  final List<TodoEntry> todoEntries = List.generate(
      100,
      (index) => TodoEntry(
          id: EntryId.fromUniqueString(index.toString()),
          description: "description $index",
          isDone: false));

  final todoCollection = List.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString("$index"),
      title: "title $index",
      color: ToDoColor(colorIndex: index % ToDoColor.predefinedColors.length),
    ),
  );

  @override
  Future<Either<Failure, List<ToDoCollection>>> readTodoCollections() {
    try {
      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(todoCollection));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final todoEntry =
          todoEntries.firstWhere((element) => entryId == element.id);
      return Right(todoEntry);
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      int endIndex = startIndex + 10;
      if (todoEntries.length < endIndex) {
        endIndex = todoEntries.length;
      }
      final entryIds =
          todoEntries.sublist(startIndex, endIndex).map((e) => e.id).toList();

      return Future.delayed(
        const Duration(milliseconds: 300),
        () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required TodoEntry entry}) {
    final index = todoEntries.indexWhere((element) => element.id == entry.id);

    final entryToUpdate = todoEntries[index];

    final updatedEntry = entryToUpdate.copyWith(isDone: !entryToUpdate.isDone);
    todoEntries[index] = updatedEntry;
    return Future.delayed(
        const Duration(milliseconds: 100), () => Right(updatedEntry));
  }

  @override
  Future<Either<Failure, bool>> createTodoCollection(
      ToDoCollection collection) {
    final collectionToAdd = ToDoCollection(
        id: CollectionId.fromUniqueString(todoCollection.length.toString()),
        title: collection.title,
        color: collection.color);
    todoCollection.add(collectionToAdd);
    return Future.delayed(
        const Duration(milliseconds: 300), () => const Right(true));
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(_, TodoEntry entry) {
    todoEntries.add(entry);

    return Future.delayed(
        const Duration(milliseconds: 250), () => const Right(true));
  }
}
