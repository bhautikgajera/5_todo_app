import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collection.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/overview/block/todo_overview_cubit.dart';

import 'view_states/error.dart';
import 'view_states/loaded_state.dart';
import 'view_states/loading_state.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoOverViewCubit(
        loadTodoCollections: LoadTodoCollections(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..getTodoCollections(),
      child: const OverViewPage(),
    );
  }
}

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  static const PageConfig pageConfig = PageConfig(
      icon: Icons.work_history_rounded,
      name: "overview",
      child: OverviewPageProvider());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoOverViewCubit, TodoOverViewCubitState>(
      builder: (context, state) {
        if (state is TodoOverviewStateLoading) {
          return const OverViewLoadingState();
        } else if (state is TodoOverviewStateLoaded) {
          return ToDOOverviewLoaded(
            collections: state.collection,
          );
        } else if (state is TodoOverviewStateError) {
          return const OverViewErrorState();
        }
        return Container(
          color: Colors.blue,
        );
      },
    );
  }
}
