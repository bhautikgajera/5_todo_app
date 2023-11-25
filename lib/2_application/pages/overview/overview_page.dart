import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/page_config.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  static const PageConfig pageConfig = PageConfig(
      icon: Icons.work_history_rounded,
      name: "overview",
      child: OverViewPage());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
