import 'dart:typed_data';

import 'package:ecommerce/model/cartItems.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading:imageBytes != null
            ? CircleAvatar(
          backgroundImage: MemoryImage(imageBytes!), //showing the image
        )
            : const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.add_a_photo_outlined,
              color: Colors.white),
        ),
        title: Text(widget.cartItems.product!.name!),
      ),
    );
  }
}
