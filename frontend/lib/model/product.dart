

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


  //Creating Product object with json
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

  @override
  String toString() {
    // TODO: implement toString
    return "$id \n $name";
  }
}