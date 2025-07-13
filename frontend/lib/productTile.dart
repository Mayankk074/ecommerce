import 'dart:typed_data';

import 'package:ecommerce/service/storageHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductTile extends StatefulWidget {
  int? id;
  String? name;
  String? description;
  String? brand;
  double? price;
  String? category;
  String? releaseDate;
  bool? isAvailable;
  int? stockQuantity;

  ProductTile(
      {super.key,
      required this.name,
      required this.price,
      required this.releaseDate,
      required this.stockQuantity,
      required this.isAvailable,
      required this.category,
      required this.brand,
      required this.description,
      required this.id});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Uint8List? imageBytes;

  //Fetching the image from server
  void getImage() async {
    final token = await SecureStorageHelper.getToken();
    final response = await http.get(
        Uri.parse('http://192.168.1.100:8080/api/product/${widget.id}/image'),
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
                      onPressed: () {},
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
                    Text("₹ ${widget.price?.toInt()}")
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
                        widget.name!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.brand!),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.description!),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.isAvailable! ? "InStock" : "Out of Stock",
                        style: TextStyle(
                          color:
                              widget.isAvailable! ? Colors.green : Colors.red,
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
