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

 
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'price': price,
      'thumbnail': thumbnail,
      'brand': brand,
    };
  }


  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      description: map['description'],
      price: map['price'],
      thumbnail: map['thumbnail'],
      images: [],
      brand: map['brand'],
    );
  }
}
