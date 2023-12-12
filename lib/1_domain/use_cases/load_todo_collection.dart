import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class LoadTodoCollections implements UseCase<List<ToDoCollection>, NoParams> {
  final ToDoRepository toDoRepository;

  LoadTodoCollections({required this.toDoRepository});

  @override
  Future<Either<Failure, List<ToDoCollection>>> call(NoParams params) async {
    final loadedCollection = await toDoRepository.readTodoCollections();
    try {
      return loadedCollection.fold((left) {
        print("Failure <<<<<<>>>>>>>>>>>>>${left}");
        return Left(left);
      }, (right) => Right(right));
    } on Exception catch (e) {
      print("Failure >>> in UseCases >>>>>>>> ${e}");
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
