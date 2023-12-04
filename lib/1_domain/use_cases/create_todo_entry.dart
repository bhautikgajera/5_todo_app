import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class CreateTodoEntry implements UseCase<bool, CreateEntryParams> {
  final ToDoRepository toDoRepository;

  const CreateTodoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = await toDoRepository.createTodoEntry(
          params.collectionId, params.entry);
      return result;
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }
}
