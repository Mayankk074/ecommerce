import 'dart:typed_data';

import 'package:ecommerce/service/storageHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/product.dart';

class ProductTile extends StatefulWidget {
  Product product;

  ProductTile({super.key, required this.product});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Uint8List? imageBytes;
  late Product product;


  //Fetching the image from server
  void getImage() async {
    final token = await SecureStorageHelper.getToken();
    final response = await http.get(
        Uri.parse('http://192.168.1.100:8080/api/product/${product.id}/image'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      setState(() {
        imageBytes = response.bodyBytes;
      });
    } else {
      print("there is an error while fetching image: ${response.statusCode}");
    }
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
                      onPressed: () {
                        Navigator.pushNamed(context, "/productDetails", arguments: {
                          'product': product,
                          'image': imageBytes
                        });
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
                    SizedBox(
                      height: 10,
                    ),
                    Text("₹ ${product.price?.toInt()}")
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(product.brand!),
                      SizedBox(
                        height: 5,
                      ),
                      Text(product.description!),
                      SizedBox(
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
