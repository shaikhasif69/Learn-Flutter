import 'package:flutter/material.dart';
import 'package:learn_flutter/Basics/myColumn.dart';
import 'package:learn_flutter/Basics/myContainer.dart';
import 'package:learn_flutter/Basics/myListView.dart';
import 'package:learn_flutter/Basics/myRow.dart';
import 'package:learn_flutter/Basics/myStack.dart';
import 'package:learn_flutter/Basics/welcome.dart';
import 'package:learn_flutter/backend/backendPage.dart';
import 'package:learn_flutter/learn1.dart';
import 'package:learn_flutter/profilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Welcome());
  }
}
