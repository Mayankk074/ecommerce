import 'dart:convert';

import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/model/cartItems.dart';
import 'package:ecommerce/service/storageHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/product.dart';

class CartService{

  //Adding the product to the cart table
  Future<String?> addToCart(Product product,int quantity, String? username)async {
    final token = await SecureStorageHelper.getToken();
    Response response=await http.post(Uri.parse('$baseUrl/api/addtocart'),
      headers: {'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'},
      //converting Product object to json with tojson() in Product which returns a Map.
      //because jsonEncode doesn't convert custom class to json.
      body: jsonEncode({'username': username, 'product': product.toJson(), 'quantity': quantity}),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  //getting all cart items
  Future<List<CartItems>>? getCart(String username) async {
    final token = await SecureStorageHelper.getToken();
    Response response=await http.get(Uri.parse("$baseUrl/api/cart/$username"), headers: {
      'Authorization': 'Bearer $token'
    });
    Iterable result=jsonDecode(response.body);

    List<CartItems> list=List<CartItems>.from(result.map((model)=> CartItems.fromJson(model)));
    return list;
  }


  //Deleting all CartItems with username
  Future buy(String username)async{
    final token = await SecureStorageHelper.getToken();
    await http.delete(Uri.parse("$baseUrl/api/cart/$username"), headers: {
      'Authorization': 'Bearer $token'
    });
  }

}