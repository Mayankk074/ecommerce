import 'dart:convert';

import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/productTile.dart';
import 'package:ecommerce/service/productService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  final TextEditingController _textEditingController=TextEditingController();
  // List<Product>? products=[];
  //
  // void getProducts() async {
  //   dynamic response=await http.get(Uri.parse("http://192.168.1.7:8080/api/products"));
  //   Iterable result=jsonDecode(response.body);
  //   setState(() {
  //     products = List<Product>.from(result.map((model)=> Product.fromJson(model)));
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getProducts();
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: ProductService().getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            List<Product>? products=snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only( right: screenWidth*0.02, left: screenWidth*0.02, top: screenHeight * 0.07,),
                  child: CupertinoSearchTextField(
                    controller: _textEditingController,
                    placeholder: "Search product",
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: products?.length,
                      itemBuilder: (context, index){
                        return ProductTile(product: products![index],);
                      }),
                )
              ],
            );
          }
        }
        return CircularProgressIndicator();
      },
    );

  }
}


