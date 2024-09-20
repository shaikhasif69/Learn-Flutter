import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRows extends StatelessWidget {
  const MyRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonRow(),
      ),
    );
  }

  Widget TextRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Text 1",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.amber),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Text 2",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.orange),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Text 3",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red),
        ),
      ],
    );
  }

  Widget ContainerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 120,
          color: Colors.amber,
          child: Center(child: Text("Container 1")),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 150,
          width: 120,
          color: Colors.amber,
          child: Center(child: Text("Container 1")),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 150,
          width: 120,
          color: Colors.amber,
          child: Center(child: Text("Container 1")),
        ),
      ],
    );
  }

  Widget ButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: Text("Button 1")),
        ElevatedButton(onPressed: () {}, child: Text("Button 1")),
        ElevatedButton(onPressed: () {}, child: Text("Button 1")),
      ],
    );
  }
}
