import 'package:ecommerce/page/addProduct.dart';
import 'package:ecommerce/page/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIdx=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Addproduct(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState((){
            currentIdx=index;
          });
        },
        currentIndex: currentIdx,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Product"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart")
        ],

      ),
    );
  }
}
