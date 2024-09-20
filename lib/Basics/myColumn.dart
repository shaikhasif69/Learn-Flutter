import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  const MyColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ContainerWidgets()
      ),
    );
  }

 Widget TextColumn() {
    return Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("data1"),
            
            Text("data2"),
        
            Text("data3"),
        
            ],
        );
  }

  Widget ContainerWidgets(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.amber,
          child: Text("Container 1"),
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.orange,
          child: Text("Container 1"),
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
          child: Text("Container 1"),
        ),
      ],
    );
  }

  Widget ButtonColumns() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: Text("Button one!")),
        ElevatedButton(onPressed: () {}, child: Text("Button one!")),
        ElevatedButton(onPressed: () {}, child: Text("Button one!")),
      ],
    );
  }
}
