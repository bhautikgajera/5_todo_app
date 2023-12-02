import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ToDoEntryItemLoading extends StatelessWidget {
  const ToDoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        color: Colors.black,
        child: const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text("Loading"),
          ),
        ));
  }
}
