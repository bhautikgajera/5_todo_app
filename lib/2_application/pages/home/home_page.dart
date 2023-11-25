import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
      : index = tabs.indexWhere((element) => element.name == tab);

  final int index;

  static const tabs = [
    DashboardPage.pageConfig,
    OverViewPage.pageConfig,
    SettingsPage.pageConfig
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final destination = HomePage.tabs
        .map((e) => NavigationDestination(icon: Icon(e.icon), label: e.name));

    return Scaffold(
      body: SafeArea(
        child: AdaptiveLayout(
          primaryNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key("primary-navigation-medium"),
              builder: (context) => AdaptiveScaffold.standardNavigationRail(
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
                return const SecondBody();
              },
            )
          }),
        ),
      ),
    );
  }

  void _onNavigatopnChanged(BuildContext context, int index) {
    context.go("/home/${HomePage.tabs[index].name}");
  }
}

class SecondBody extends StatelessWidget {
  const SecondBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print("Second Body Called");
    return const Placeholder();
  }
}
