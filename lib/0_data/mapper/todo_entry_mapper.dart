import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

mixin EntryMapper {
  ToDoEntryModel todoEntryToModel(TodoEntry entry) {
    return ToDoEntryModel(
        id: entry.id.value,
        description: entry.description,
        isDone: entry.isDone);
  }

  TodoEntry todoModelToEntity(ToDoEntryModel entry) {
    return TodoEntry(
        id: EntryId.fromUniqueString(entry.id),
        description: entry.description,
        isDone: entry.isDone);
  }
}
