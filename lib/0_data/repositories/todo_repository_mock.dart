import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements ToDoRepository {
  @override
  Future<Either<Failure, List<ToDoCollection>>> readTodoCollections() {
    final lits = List.generate(
      10,
      (index) => ToDoCollection(
        id: CollectionId.fromUniqueString("$index"),
        title: "title $index",
        color: ToDoColor(colorIndex: index % ToDoColor.predefinedColors.length),
      ),
    );
    return Future.delayed(const Duration(milliseconds: 300), () => Right(lits));
  }
}
