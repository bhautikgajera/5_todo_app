import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/block/navigation_todo_cubit.dart';

class ToDOOverviewLoaded extends StatelessWidget {
  const ToDOOverviewLoaded({super.key, required this.collections});

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          return BlocBuilder<NavigationTodoCubit, NavigationTodoCubitState>(
            buildWhen: (previous, current) =>
                previous.selectedCollectionId != current.selectedCollectionId,
            builder: (context, state) {
              return ListTile(
                onTap: () {
                  if (Breakpoints.small.isActive(context)) {
                    context.pushNamed(ToDoDetailPage.pageConfig.name,
                        pathParameters: {"collectionID": item.id.value});
                  } else {
                    context
                        .read<NavigationTodoCubit>()
                        .selectedTodoCollectionChanged(
                            isSecondBodyDisplayed: true, collectionId: item.id);
                  }
                },
                selected: state.selectedCollectionId == item.id,
                tileColor: colorScheme.surface,
                selectedTileColor: colorScheme.surfaceVariant,
                iconColor: item.color.color,
                selectedColor: item.color.color,
                leading: const Icon(Icons.circle),
                title: Text(item.title),
              );
            },
          );
        });
  }
}
