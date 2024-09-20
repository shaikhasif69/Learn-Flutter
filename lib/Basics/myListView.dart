import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final List<Map<String, String>> products = [
    {"title": "Product 1", "subtitle": "This is the first product."},
    {"title": "Product 2", "subtitle": "This is the second product."},
    {"title": "Product 3", "subtitle": "This is the third product."},
    {"title": "Product 4", "subtitle": "This is the fourth product."},
    {"title": "Product 5", "subtitle": "This is the fifth product."},
    {"title": "Product 6", "subtitle": "This is the fifth product."},
    {"title": "Product 7", "subtitle": "This is the fifth product."},
    {"title": "Product 8", "subtitle": "This is the fifth product."},
    {"title": "Product 9", "subtitle": "This is the fifth product."},
    {"title": "Product 10", "subtitle": "This is the fifth product."},
    {"title": "Product 11", "subtitle": "This is the fifth product."},
    {"title": "Product 12", "subtitle": "This is the fifth product."},
    {"title": "Product 13", "subtitle": "This is the fifth product."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_cart), // Icon for each product
            title: Text(products[index]["title"]!),
            subtitle: Text(products[index]["subtitle"]!),
          );
        },
      ),
    );
  }
}
