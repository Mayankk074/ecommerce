import 'dart:typed_data';

import 'package:ecommerce/service/productService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product.dart';
import '../../../model/user.dart';
import '../../../service/cartService.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _formKey=GlobalKey<FormState>();
  int quantity=0;


  void _resetForm() {
    _formKey.currentState?.reset();

    setState(() {
      quantity = 0;
    });
  }

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
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsetsGeometry.all(8),
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
                const SizedBox(height: 20,),
                Text(
                  product.name!,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  product.brand!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20,),
                Text(
                  "₹ ${product.price}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20,),
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
                      if(num == null || num <= 0 || num > 9) return 'Quantity should be 1-9';

                      return null;
                    },
                    onChanged: (val) {
                      final num = int.tryParse(val);
                      //value should be not null and greater than 0
                      if(num != null && num > 0)  quantity=num;
                    },
                    style: Theme.of(context).textTheme.titleSmall
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed:()async {
                    if(_formKey.currentState!.validate()){
                      //Adding the product to the cart with current user
                      dynamic response=await CartService().addToCart(product, quantity, user?.username);

                      if(response != null){
                        //showing the snackbar and resetting the form
                        const snackbar=SnackBar(content: Text("Added to the cart successfully"));
                        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        _resetForm();
                      }
                      else{
                        const snackbar=SnackBar(content: Text("There is some error!!"));
                        if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                  },
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(fixedSize: const WidgetStatePropertyAll(Size(300,60))),
                  child: const Text('Add to cart')
                ),
                const SizedBox(height: 20,),
                Text(
                  product.description!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20,),
                Text(
                  product.category!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20,),
                Text(
                  product.releaseDate!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20,),
                Text(
                  "${product.stockQuantity}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
