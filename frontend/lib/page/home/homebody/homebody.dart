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

  List<Product>? searchProducts;
  final TextEditingController _textEditingController=TextEditingController();


  void updateHomePage(){
    setState(() {});
  }

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
            if(products!.isNotEmpty){
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only( right: screenWidth*0.02, left: screenWidth*0.02, top: screenHeight * 0.07,),
                    child: CupertinoSearchTextField(
                      controller: _textEditingController,
                      placeholder: "Search product",
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      onSubmitted: (val)async{
                        //when user hit search button on keyboard it will search and get List<Product> from server
                        searchProducts = await ProductService().searchProduct(val);
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    //Show all products if user has not searched.
                    child: searchProducts == null ? ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index){
                          return ProductTile(product: products[index], updateHomePage: updateHomePage,);
                        }) : ListView.builder(
                        itemCount: searchProducts?.length,
                        itemBuilder: (context, index){
                          return ProductTile(product: searchProducts![index], updateHomePage: updateHomePage,);
                        })
                  )
                ],
              );
            }
            else{
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
      },
    );

  }
}


