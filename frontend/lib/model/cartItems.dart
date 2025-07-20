import 'package:ecommerce/model/product.dart';

class CartItems{
  int? id;
  Product? product;
  int? quantity;
  String? username;

  CartItems({this.quantity, this.username, this.id, this.product});

  //converting json to CartItems object
  factory CartItems.fromJson(Map<String, dynamic> json){
    return CartItems(
      quantity: json['quantity'],
      username: json['username'],
      //converting json to Product Object
      product: Product.fromJson(json['product'])
    );
  }
}