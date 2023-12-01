import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class LoadTodoEntry implements UseCase<TodoEntry, TodoEntryIdsParam> {
  final ToDoRepository toDoRepository;

  LoadTodoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, TodoEntry>> call(TodoEntryIdsParam params) async {
    final loadedEntry =
        await toDoRepository.readTodoEntry(params.collectionId, params.entryId);

    return loadedEntry.fold(
      (left) => Left(left),
      (right) => Right(right),
    );
  }
}
