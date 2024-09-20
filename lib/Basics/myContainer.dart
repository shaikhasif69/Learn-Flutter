import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: descriptiveContainer()));
  }

  Widget normalContainer() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.orange,
    );
  }

  Widget curveContainer() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          // color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [Colors.red, Colors.orange])),
    );
  }

  Widget descriptiveContainer() {
    return Container(
      height: 130,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "images/cat2.jpg",
                width: 70,
              ),
            ),
          ), 
          const Text("Cat cathingon!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),), 
          const Text("21",  style: TextStyle(fontSize: 16,))
        ],
      ),
    );
  }
}
