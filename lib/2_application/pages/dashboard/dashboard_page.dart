import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/page_config.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const PageConfig pageConfig = PageConfig(
      icon: Icons.dashboard, name: "dashboard", child: DashboardPage());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.amber,
      ),
    );
  }
}
