import 'dart:typed_data';

import 'package:ecommerce/service/productService.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {

    final data=ModalRoute.of(context)?.settings.arguments as Map;
    Product product=data['product'];
    Uint8List? imageBytes=data['image'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              showDialog(context: context,
              builder: (BuildContext context){
                //Asking for deletion of product
                return AlertDialog(
                  title: const Text('Alert!!'),
                  content: const SingleChildScrollView(
                      child: Text(
                          'Do you really want to Delete this product?'
                      )
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () async {
                        //Deleting the product
                        await ProductService().deleteById(product.id);
                        if(context.mounted) Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.c,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(imageBytes!),
                  fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(height: 20,),
            Text(
              product.name!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 20,),
            Text(
              product.brand!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20,),
            Text(
              "₹ ${product.price}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20,),
            Text(
              product.description!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20,),
            Text(
              product.category!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20,),
            Text(
              product.releaseDate!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      )
    );
  }
}
