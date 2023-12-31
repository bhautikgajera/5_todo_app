import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/components/todo_entry_item/todo_entry_item.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/2_application/pages/detail/block/cubit/todo_detail_cubit.dart';

typedef TodoEntryItemAddedCallBack = Function();

class CreateTodoEntryPageExtra {
  final CollectionId collectionId;
  final TodoEntryItemAddedCallBack callBack;

  const CreateTodoEntryPageExtra(
      {required this.collectionId, required this.callBack});
}

class TodoDetailLoaded extends StatelessWidget {
  const TodoDetailLoaded(
      {super.key, required this.entryIds, required this.collectionId});

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) => TodoEntryItemProvider(
                collectionId: collectionId,
                entryId: entryIds[index],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  await context.pushNamed(CreateTodoEntryPage.pageConfig.name,
                      extra: collectionId);

                  // ignore: use_build_context_synchronously
                  context.read<TodoDetailCubit>().fetch();
                },
                child: const Icon(Icons.add_task_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
