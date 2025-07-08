

class Product{
  int? id;
  String? name;
  String? description;
  String? brand;
  int? price;
  String? category;
  DateTime? releaseDate;
  bool? isAvailable;
  int? stockQuantity;

  Product({this.name, this.id, this.price, this.description, this.brand,
    this.category, this.isAvailable, this.releaseDate, this.stockQuantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'prodName': String name, 'price':int price, 'prodId': int id} => Product(
        name: name,
        id: id,
        price: price
      ),
      _ => throw const FormatException('Failed to load products.'),
    };
  }
}