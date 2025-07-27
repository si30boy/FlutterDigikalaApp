class Product {
  String id;
  String name;
  String price;
  String image;
  String description;

  Product(this.id, this.name, this.price, this.image, this.description);

  // از JSON ساختن
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'].toString(),
      json['name'] ?? '',
      json['price'].toString(),
      json['image_url'] ?? '',
      json['description'] ?? '',
    );
  }
}
