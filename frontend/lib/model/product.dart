

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


  //Creating json from product
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description':description,
      'brand': brand,
      'price': price,
      'category':category,
      'releaseDate':releaseDate,
      'isAvailable':isAvailable,
      'stockQuantity':stockQuantity
    };
  }


  //Creating Product object from json
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      releaseDate: json['releaseDate'],
      isAvailable: json['productAvailable'],
      stockQuantity: json['stockQuantity'],
      );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id \n $name";
  }
}