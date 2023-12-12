import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

mixin CollectionMapper {
  ToDoCollectionModel todoCollectionToModel(ToDoCollection collection) {
    return ToDoCollectionModel(
        id: collection.id.value,
        title: collection.title,
        colorIndex: collection.color.colorIndex);
  }

  ToDoCollection todoCollectionModelToEntity(ToDoCollectionModel collection) {
    return ToDoCollection(
        id: CollectionId.fromUniqueString(collection.id),
        title: collection.title,
        color: ToDoColor(colorIndex: collection.colorIndex));
  }
}
