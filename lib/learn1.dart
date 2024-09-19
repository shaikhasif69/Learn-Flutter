import 'package:flutter/material.dart';

class Learn1 extends StatelessWidget {
  const Learn1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.amber,
        ),
        
        Positioned(
          left: 10,
          top: 100,
          child: Container(
            height: 200,
            width: 150,
            color: Colors.red,
          ),
        ),
         Positioned(
          top: 20,
          right: 10,
           child: Container(
            height: 200,
            width: 100,
            color: Colors.white, 
                   ),
         ),
      ],
    );
  }
}