import 'package:flutter/material.dart';

import 'addProduct.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
