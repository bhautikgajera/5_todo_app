import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/form_value.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/block/create_todo_entry_page_cubit.dart';

class CreateTodoEntryPageProvider extends StatelessWidget {
  const CreateTodoEntryPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoEntryPageCubit(
          collectionId: collectionId,
          createTodoEntry: CreateTodoEntry(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context))),
      child: const CreateTodoEntryPage(),
    );
  }
}

class CreateTodoEntryPage extends StatefulWidget {
  const CreateTodoEntryPage({super.key});

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.add_task_outlined,
    name: "create_todo_entry",
    child: Placeholder(),
  );

  @override
  State<CreateTodoEntryPage> createState() => _CreateTodoEntryPageState();
}

class _CreateTodoEntryPageState extends State<CreateTodoEntryPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  final ValidationStatus validateStatus = context
                          .read<CreateTodoEntryPageCubit>()
                          .state
                          .description
                          ?.validationStatus ??
                      ValidationStatus.pending;

                  switch (validateStatus) {
                    case ValidationStatus.error:
                      return "This Field Needs at least two charecter to be valid";
                    case ValidationStatus.success:
                      return null;
                    case ValidationStatus.pending:
                      return "Pending";
                    default:
                      return null;
                  }
                },
                onChanged: (value) {
                  context
                      .read<CreateTodoEntryPageCubit>()
                      .descriptionChanged(value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  if (!isValid) {
                    return;
                  }
                  context.read<CreateTodoEntryPageCubit>().submit(context);
                },
                child: const Text("Save Entry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
