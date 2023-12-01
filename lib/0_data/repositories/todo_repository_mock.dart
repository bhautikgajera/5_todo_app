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
      final endIndex = startIndex + 10;
      final entryIds =
          todoEntries.sublist(startIndex, endIndex).map((e) => e.id).toList();

      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(entryIds));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId}) {
    final index = todoEntries.indexWhere((element) => element.id == entryId);

    final entryToUpdate = todoEntries[index];

    final updatedEntry = entryToUpdate.copyWith(isDone: !entryToUpdate.isDone);
    todoEntries[index] = updatedEntry;
    return Future.delayed(
        const Duration(milliseconds: 100), () => Right(updatedEntry));
  }
}
