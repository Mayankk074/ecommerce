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
    print("addToCart");
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
      print("there is an error while fetching image: ${response.statusCode}");
      return null;
    }
  }

  //getting all cart items
  Future<List<CartItems>>? getCart() async {
    final token = await SecureStorageHelper.getToken();
    Response response=await http.get(Uri.parse("$baseUrl/api/cart"), headers: {
      'Authorization': 'Bearer $token'
    });
    Iterable result=jsonDecode(response.body);

    List<CartItems> list=List<CartItems>.from(result.map((model)=> CartItems.fromJson(model)));
    print(list[0].quantity);
    return list;
  }

}