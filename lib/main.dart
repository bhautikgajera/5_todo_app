import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/0_data/dataspurces/interfaces/todo_remote_data_source_interface.dart';
import 'package:todo_app/0_data/dataspurces/local/hive_locale_data_source.dart';
import 'package:todo_app/0_data/dataspurces/remote/firestore_data_source_impl.dart';
import 'package:todo_app/0_data/repositories/todo_repository_local.dart';
import 'package:todo_app/0_data/repositories/todo_repository_mixed.dart';
import 'package:todo_app/0_data/repositories/todo_repository_remote.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/2_application/app/cubit/auth_cubit.dart';
import 'package:todo_app/firebase_options.dart';

import '2_application/app/basic_app.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
// late final FirebaseAuth auth;

final authCubit = AuthCubit();

final auth = FirebaseAuth.instance;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // // We store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  auth.authStateChanges().listen((event) {
    print("Auth Listner Called");
    authCubit.authStateChanged(user: event);
  });
  ui_auth.FirebaseUIAuth.configureProviders([
    ui_auth.PhoneAuthProvider(),
  ]);
  // auth = FirebaseAuth.instanceFor(app: app);

  // if (shouldUseFirebaseEmulator) {
  //   await auth.useAuthEmulator('localhost', 9099);
  // }

// initialize HIve >>>>>
  final hiveDataSource = HiveLocaleDataSource();
  await hiveDataSource.init();

  final remoteRepository =
      ToDoRepositoryRemote(remoteDataSourceInterface: FireStoreDataImpl());

  final localeRepository = ToDoRepositoryLocal(localDataSource: hiveDataSource);

  runApp(RepositoryProvider<ToDoRepository>(
    create: (context) => ToDoRepositoryMixed(
        localeRepository: localeRepository, remoteRepository: remoteRepository),
    child: BlocProvider(
      create: (context) => authCubit,
      child: const BasicApp(),
    ),
  ));
}
