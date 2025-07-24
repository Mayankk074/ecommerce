import 'dart:typed_data';

import 'package:ecommerce/model/cartItems.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../../service/productService.dart';


class CartTile extends StatefulWidget {
  CartItems cartItems;
  CartTile({super.key, required this.cartItems});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  Uint8List? imageBytes;


  //Fetching the image from server
  void getImage() async {
    imageBytes= await ProductService().getImage(widget.cartItems.product?.id);
    setState((){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  // title: Text(widget.cartItems.product!.name!),

  @override
  Widget build(BuildContext context) {
    Product? product=widget.cartItems.product;
    return Card(
      elevation: 8,
      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                imageBytes != null
                    ? CircleAvatar(
                  backgroundImage: MemoryImage(imageBytes!), //showing the image
                  radius: 50,
                )
                    : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 50,
                  child: Icon(Icons.add_a_photo_outlined,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("₹ ${product?.price?.toInt()}")
              ],
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                children: [
                  Text(
                    product!.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(product.brand!),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(product.description!),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.isAvailable! ? "InStock" : "Out of Stock",
                    style: TextStyle(
                      color:
                      product.isAvailable! ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Quantity: ${widget.cartItems.quantity}",
                    style: TextStyle(
                      color:
                      product.isAvailable! ? Colors.green : Colors.green,
                    ),
                  ),
                ],
              )
            )
          ]
        ),

      )
    );
  }
}
