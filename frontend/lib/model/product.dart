

class Product{
  int? id;
  String? name;
  String? description;
  String? brand;
  double? price;
  String? category;
  String? releaseDate;
  bool? isAvailable;
  int? stockQuantity;

  Product({this.name, this.id, this.price, this.description, this.brand,
    this.category, this.isAvailable, this.releaseDate, this.stockQuantity});


  //simpler version of below code
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      price: json['price'],
      category: json['category'],
      releaseDate: json['releaseDate'],
      isAvailable: json['productAvailable'],
      stockQuantity: json['stockQuantity'],
      );
  }

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return switch (json) {
  //     {'id': int id, 'name': String name, 'description': String description, 'brand': String brand,
  //     'price':double price, 'category':String category, 'releaseDate': String releaseDate, 'productAvailable': bool isAvailable,
  //     'stockQuantity': int stockQuantity} => Product(
  //       id: id,
  //       name: name,
  //       description: description,
  //       brand: brand,
  //       price: price,
  //       category: category,
  //       releaseDate: releaseDate,
  //       isAvailable: isAvailable,
  //       stockQuantity: stockQuantity
  //     ),
  //     _ => throw const FormatException('Failed to load products.'),
  //   };
  // }

  @override
  String toString() {
    // TODO: implement toString
    return "$id \n $name";
  }
}