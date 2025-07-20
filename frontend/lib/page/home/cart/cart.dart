import 'package:ecommerce/service/cartService.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            CartService().getCart();
          },
          child: Text('Press'))
      ),
    );
  }
}
