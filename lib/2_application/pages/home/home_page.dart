import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/block/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key, required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationTodoCubit>(
      create: (context) => NavigationTodoCubit(),
      child: HomePage(
        tab: tab,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
      : index = tabs.indexWhere((element) => element.name == tab);

  static const PageConfig pageConfig =
      PageConfig(icon: Icons.home_max_rounded, name: "home");

  final int index;

  static const tabs = [
    DashboardPage.pageConfig,
    OverViewPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final themeData = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    final destination = HomePage.tabs
        .map((e) => NavigationDestination(icon: Icon(e.icon), label: e.name));

    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          topNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key(
                "small-app-bar",
              ),
              builder: (context) {
                return Row(
                  children: [
                    Text(HomePage.tabs[widget.index].name),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          context.pushNamed(SettingsPage.pageConfig.name),
                      icon: Icon(SettingsPage.pageConfig.icon),
                    )
                  ],
                );
              },
            )
          }),
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key("primary-navigation-medium"),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
                trailing: IconButton(
                  onPressed: () =>
                      context.pushNamed(SettingsPage.pageConfig.name),
                  icon: Icon(SettingsPage.pageConfig.icon),
                ),
                selectedLabelTextStyle:
                    TextStyle(color: themeData.colorScheme.onBackground),
                selectedIconTheme:
                    IconThemeData(color: themeData.colorScheme.onBackground),
                unselectedIconTheme: IconThemeData(
                    color: themeData.colorScheme.onBackground.withOpacity(0.5)),
                selectedIndex: widget.index,
                onDestinationSelected: (index) =>
                    _onNavigatopnChanged(context, index),
                destinations: destination
                    .map((element) =>
                        AdaptiveScaffold.toRailDestination(element))
                    .toList(),
              ),
            ),
          }),
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key(
                  "Bottom-navigation-small",
                ),
                builder: (context) =>
                    AdaptiveScaffold.standardBottomNavigationBar(
                  currentIndex: widget.index,
                  onDestinationSelected: (index) =>
                      _onNavigatopnChanged(context, index),
                  destinations: destination.toList(),
                ),
              )
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.smallAndUp: SlotLayout.from(
                key: const Key(
                  "Primary-Body",
                ),
                builder: (context) => HomePage.tabs[widget.index].child,
              )
            },
          ),
          secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key("Secondary-Body"),
              builder: (context) {
                if (widget.index == 1) {
                  return BlocBuilder<NavigationTodoCubit,
                      NavigationTodoCubitState>(builder: (context, state) {
                    final isSecondBodydisplaied =
                        Breakpoints.mediumAndUp.isActive(context);
                    context
                        .read<NavigationTodoCubit>()
                        .selectedTodoCollectionChanged(
                            isSecondBodyDisplayed: isSecondBodydisplaied,
                            collectionId: state.selectedCollectionId);
                    if (state.selectedCollectionId != null) {
                      return TodoDetailPageProvider(
                          key: UniqueKey(),
                          collectionId: state.selectedCollectionId!);
                    }
                    return const Placeholder();
                  });
                }
                return const SecondBody();
              },
            )
          }),
        ),
      ),
    );
  }

  void _onNavigatopnChanged(BuildContext context, int index) {
    context.goNamed(HomePage.pageConfig.name,
        pathParameters: {"tab": HomePage.tabs[index].name});
  }
}

class SecondBody extends StatelessWidget {
  const SecondBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Placeholder());
  }
}
