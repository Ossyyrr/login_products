// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
  });

  String? id;
  bool available;
  String name;
  String? picture;
  double price;

  Product productFromJson(String str) => Product.fromJson(json.decode(str));
  String productToJson(Product data) => json.encode(data.toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };
}
