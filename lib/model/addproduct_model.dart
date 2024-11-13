// To parse this JSON data, do
//
//     final addProductResModel = addProductResModelFromJson(jsonString);

import 'dart:convert';

AddProductResModel addProductResModelFromJson(String str) =>
    AddProductResModel.fromJson(json.decode(str));

String addProductResModelToJson(AddProductResModel data) =>
    json.encode(data.toJson());

class AddProductResModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  String? category;

  AddProductResModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.category,
  });

  factory AddProductResModel.fromJson(Map<String, dynamic> json) =>
      AddProductResModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "image": image,
        "category": category,
      };
}
