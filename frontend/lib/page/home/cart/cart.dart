import 'package:ecommerce/model/cartItems.dart';
import 'package:ecommerce/service/cartService.dart';
import 'package:flutter/material.dart';

import 'cartTile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<CartItems>? cartItems;

  void getCartItems()async{
    cartItems=await CartService().getCart();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItems();
  }
  @override
  Widget build(BuildContext context) {
    if(cartItems != null){
      return ListView.builder(
        itemCount: cartItems!.length,
        itemBuilder: (context, index){
          return CartTile(cartItems: cartItems![index]);
        });
    }
    else{
      return CircularProgressIndicator();
    }

  }
}
