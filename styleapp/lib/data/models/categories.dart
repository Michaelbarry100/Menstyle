import 'dart:convert';

import 'package:equatable/equatable.dart';

class Category extends Equatable {
  
  final int id;
  final String name;
  final String image;
  final int totalStyles;
  final int? collectionId;
  final String? description;

  const Category({
    required this.id,
    required this.name,
    required this.image,
    required this.totalStyles,
    required this.collectionId,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, image, description];

  factory Category.fromJson(Map<String, dynamic> json) {
    var category = Category(
      id: json['id'],
      name: json['name'],
      image: json['featured_image'],
      collectionId: json['collection_id'] ,
      description: json['description'] ?? '',
      totalStyles: json['items_count'],
    );
    return category;
  }

  String toJson() {
    return json.encode({
      "id": id,
      "name": name,
      "description": description,
      "featured_image": image,
      "collection_id": collectionId,
      "items_count": totalStyles,
    });
  }

}
