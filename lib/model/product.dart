class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.brand,
    required this.image,
  });

  static empty() => ProductModel(
      id: '',
      title: '',
      description: '',
      price: 0,
      rating: 0,
      brand: '',
      image: '');

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Extract the list of image URLs from the JSON data

    return ProductModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      brand: json['brand'] ?? '',
      image: json['images'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'brand': brand,
      'images': image,
    };
  }
}
