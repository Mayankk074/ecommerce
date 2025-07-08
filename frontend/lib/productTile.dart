import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  String name;
  int price;
  ProductTile({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red[300],
          ),
          title: Text(name),
          subtitle: Text("$price"),
        )
      ),
    );
  }
}
