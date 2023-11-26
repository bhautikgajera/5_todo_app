import 'package:flutter/material.dart';

class OverViewLoadingState extends StatelessWidget {
  const OverViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive();
  }
}
