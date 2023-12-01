import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/detail/block/cubit/todo_detail_cubit.dart';
import 'package:todo_app/2_application/pages/detail/view_state/todo_detail_error.dart';
import 'package:todo_app/2_application/pages/detail/view_state/todo_detail_loaded.dart';

import 'view_state/todo_detail_loading.dart';

class TodoDetailPageProvider extends StatelessWidget {
  const TodoDetailPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoDetailCubit(
        collectionId: collectionId,
        loadTodoEntryIdsForCollection: LoadTodoEntryIdsForCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: ToDoDetailPage(collectionId: collectionId),
    );
  }
}

class ToDoDetailPage extends StatelessWidget {
  const ToDoDetailPage({super.key, required this.collectionId});

  final CollectionId collectionId;

  static const PageConfig pageConfig = PageConfig(
      icon: Icons.details_rounded, name: "detail", child: Placeholder());

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name;

    if (name != null &&
        (name == pageConfig.name) &&
        Breakpoints.mediumAndUp.isActive(context) &&
        context.canPop()) {
      context.pop();
    }
    return BlocBuilder<TodoDetailCubit, TodoDetailCubitState>(
      builder: (context, state) {
        if (state is TodoDetailLoadeingState) {
          return const DotoDetailLoading();
        } else if (state is TodoDetailLoadedState) {
          return TodoDetailLoaded(
              entryIds: state.entryIds, collectionId: collectionId);
        } else if (state is TodoDetailError) {
          return const TodoDetailError();
        }
        return const Placeholder();
      },
    );
  }
}
