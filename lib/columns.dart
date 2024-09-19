import 'package:flutter/material.dart';

class ColumnsExamples extends StatelessWidget {
  const ColumnsExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text("hello!"),
        ),

        Center(
          child: Text("There!"),
        )
      ],
    );
  }
}