class Product {
  final String title;
  final String category;
  final num price;
  final String thumbnail;

  Product({
    required this.title,
    required this.category,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      category: json['category'],
      price: json['price'],
      thumbnail: json['thumbnail'],
    );
  }
}
