import 'package:ecommerce/model/cartItems.dart';
import 'package:ecommerce/service/cartService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';
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
    final user = Provider.of<User?>(context);
      return FutureBuilder(
        //getting all cartItems from server
        future: CartService().getCart(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<CartItems>? products = snapshot.data;
              if (products!.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cartItems!.length,
                          itemBuilder: (context, index) {
                            return CartTile(cartItems: cartItems![index]);
                          }
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await CartService().buy(user!.username!);
                          //updating the UI with
                          setState(() {});
                        },
                        child: Text("Buy"))
                  ],
                );
              }
              else {
                return const Center(
                  child: Text(
                    "No products",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                );
              }
            }
        }
        return const CircularProgressIndicator();
      }
      );
  }
}
