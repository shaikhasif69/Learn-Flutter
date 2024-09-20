import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.amber,
            ),
          ),
          Positioned(
            top: 30, // Slightly shifted down
            left: 30, // Slightly shifted to the right
            child: Container(
              width: 200,
              height: 200,
              color: Colors.orange,
            ),
          ),
          Positioned(
            top: 60, // More shifted down
            left: 60, // More shifted to the right
            child: Container(
              width: 200,
              height: 200,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
