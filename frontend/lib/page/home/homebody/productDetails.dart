import 'dart:typed_data';

import 'package:ecommerce/service/productService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product.dart';
import '../../../model/user.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _formKey=GlobalKey<FormState>();
  int quantity=0;
  @override
  Widget build(BuildContext context) {

    //Fetching logged in user to add in cart table
    final user=Provider.of<User?>(context);
    //getting product details from ProductTile
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
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
                // SizedBox(height: 20,),
                // Text(
                //   product.releaseDate!,
                //   style: Theme.of(context).textTheme.titleMedium,
                // ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Quantity",
                      hintStyle: TextStyle(
                          color: Colors.grey
                      )
                  ),
                  validator: (val) {
                    //checking val is not empty or null for parsing
                    if(val == null || val.isEmpty ) return 'Enter a valid quantity';
                    //if val is not a number then it will return null.
                    final num = int.tryParse(val);
                    if(num == null || num <= 0) return 'enter a valid quantity';

                    return null;
                  },
                  onChanged: (val) {
                    final num = int.tryParse(val);
                    if(num != null || num! > 0)  quantity=num;
                  },
                  style: Theme.of(context).textTheme.titleSmall
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed:()async {
                    if(_formKey.currentState!.validate()){
                      //Adding the product to the cart with current user
                      dynamic response=await ProductService().addToCart(product, quantity, user?.username);
                      print(response);
                    }
                  } ,
                  child: Text('Add to cart'))
              ],
            ),
          ),
        ),
      )
    );
  }
}
