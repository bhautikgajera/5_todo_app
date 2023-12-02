import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class CreateTodoCollection implements UseCase<bool, CreateCollectionParam> {
  final ToDoRepository toDoRepository;

  CreateTodoCollection({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(CreateCollectionParam params) async {
    try {
      final createdEntry =
          await toDoRepository.createTodoCollection(params.collection);

      return createdEntry;
    } on Exception {
      return Left(ServerFailure(stackTrace: "somthing Went Wrong In Server"));
    }
  }
}
