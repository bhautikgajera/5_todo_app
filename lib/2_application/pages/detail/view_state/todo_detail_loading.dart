import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DotoDetailLoading extends StatelessWidget {
  const DotoDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer(child: const Text("Loading")),
    );
  }
}
