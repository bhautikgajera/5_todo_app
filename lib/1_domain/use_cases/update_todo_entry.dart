import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class UpdateTodoEntry extends UseCase<TodoEntry, TodoEntryIdsParam> {
  UpdateTodoEntry({required this.toDoRepository});
  final ToDoRepository toDoRepository;
  @override
  Future<Either<Failure, TodoEntry>> call(TodoEntryIdsParam params) async {
    try {
      final loadedEntry = await toDoRepository.updateTodoEntry(
          collectionId: params.collectionId, entryId: params.entryId);
      return loadedEntry;
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
