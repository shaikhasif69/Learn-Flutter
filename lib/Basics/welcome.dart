import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(96, 172, 234, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Center(child: Text("Welcom to my session!s")),
          ElevatedButton(onPressed: 
        (){
          print("clicking button!");
        }
          , child: Text("Click me!")),
        ],
      ),
    );
  }
}
