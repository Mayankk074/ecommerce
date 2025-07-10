

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecommerce/model/product.dart';

class ProductService{

  //Adding product to database
  Future addProduct(map) async {
    await http.post(Uri.parse("http://192.168.1.8:8080/products"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(map)
    );
  }

  //getting all products
  Future<List<Product>>? getProducts() async {
    dynamic response=await http.get(Uri.parse("http://192.168.1.8:8080/products"));
    Iterable result=jsonDecode(response.body);
    return List<Product>.from(result.map((model)=> Product.fromJson(model)));
  }



}