import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "shell");

const String basePath = "/home";

final route = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  initialLocation: "$basePath/dashboard",
  routes: [
    GoRoute(
      path: "$basePath/${SettingsPage.pageConfig.name}",
      name: SettingsPage.pageConfig.name,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      name: ToDoDetailPage.pageConfig.name,
      path: "$basePath/overview/:collectionID",
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: TodoDetailPageProvider(
          collectionId: CollectionId.fromUniqueString(
              state.pathParameters['collectionID']!),
        ),
      ),
    ),
    GoRoute(
      path: "$basePath/${CreateTodoCollectionPage.pageConfig.name}",
      name: CreateTodoCollectionPage.pageConfig.name,
      builder: (context, state) => const CreateTodoCollectionPageProvider(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          name: HomePage.pageConfig.name,
          path: "$basePath/:tab",
          builder: (context, state) => HomePage(
              key: state.pageKey,
              tab: state.pathParameters["tab"] ?? "dashboard"),
        ),
      ],
      builder: (context, state, child) => child,
    ),
  ],
);
