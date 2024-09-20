import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatApp extends StatefulWidget {
  @override
  _CatAppState createState() => _CatAppState();
}

class _CatAppState extends State<CatApp> {
  List cats = [];

  // Fetch cat data from the Node.js API
  Future<void> fetchCats() async {
    final response = await http.get(Uri.parse('http://192.168.223.46:3000/api/cats'));
    if (response.statusCode == 200) {
      setState(() {
        cats = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCats(); // Fetch data when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cat Profiles'),
          backgroundColor: Colors.orange,
        ),
        body: cats.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : ListView.builder(
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  final cat = cats[index];
                  return Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange[200]!,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${cat['name']}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange[800]),
                        ),
                        SizedBox(height: 5),
                        Text("Age: ${cat['age']} years"),
                        Text("Color: ${cat['color']}"),
                        Text("Breed: ${cat['breed']}"),
                        Text("Favorite Food: ${cat['favoriteFood']}"),
                        SizedBox(height: 10),
                        Text(
                          "Description: ${cat['description']}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
