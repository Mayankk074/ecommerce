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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
      return FutureBuilder(
        //getting all cartItems from server
        future: CartService().getCart(user!.username!),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<CartItems>? cartItems = snapshot.data;
              if (cartItems!.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return CartTile(cartItems: cartItems[index]);
                          }
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await CartService().buy(user.username!);
                          //updating the UI with
                          setState(() {});
                        },
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(fixedSize: const WidgetStatePropertyAll(Size(300,60))),
                        child: const Text("Buy")
                    ),
                    const SizedBox(height: 20,)
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
