import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_collection.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/block/create_collection_page_cubit.dart';

class CreateTodoCollectionPageProvider extends StatelessWidget {
  const CreateTodoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCollectionCubit(
          createTodoCollection: CreateTodoCollection(
              toDoRepository: RepositoryProvider.of<ToDoRepository>(context))),
      child: const CreateTodoCollectionPage(),
    );
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  const CreateTodoCollectionPage({super.key});

  static const PageConfig pageConfig = PageConfig(
      icon: Icons.task_alt_outlined,
      name: "create_toto_collection",
      child: CreateTodoCollectionPageProvider());

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateCollectionCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                onChanged: (value) => cubit.titleChanged(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Title";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Color"),
                onChanged: (value) => cubit.colorChanged(value),
                validator: (value) {
                  final number = int.tryParse(value.toString());
                  if (number == null ||
                      number < 0 ||
                      number > (ToDoColor.predefinedColors.length - 1)) {
                    return "Please Choose Correct Number";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _fromKey.currentState?.validate();
                  if (isValid == true) {
                    cubit.submit(context);
                  }
                },
                child: const Text("Add todo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
