import 'dart:typed_data';

import 'package:ecommerce/service/productService.dart';
import 'package:ecommerce/service/storageHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/product.dart';

class ProductTile extends StatefulWidget {
  Product product;

  Function updateHomePage;

  ProductTile({super.key, required this.product, required this.updateHomePage});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Uint8List? imageBytes;
  late Product product;


  //Fetching the image from server
  void getImage() async {
    imageBytes= await ProductService().getImage(product.id);
    setState((){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product=widget.product;
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    CupertinoButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, "/productDetails", arguments: {
                          'product': product,
                          'image': imageBytes
                        });
                        //Update the HomePage, product is deleted so it will reflect in Home page.
                        widget.updateHomePage();
                      },
                      child: imageBytes != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(imageBytes!), //showing the image
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.add_a_photo_outlined,
                                  color: Colors.white),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("₹ ${product.price?.toInt()}")
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name!,
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
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
