class Product {
  final int id;
  final String title;
  final String category;
  final String description;
  final num price;
  final String thumbnail;
  final List<String> images;
  final String brand;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      brand: json['brand'] ?? '',
    );
  }
}
