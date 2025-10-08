import 'dart:convert';

import 'package:equatable/equatable.dart';

class Style extends Equatable {
  final int id;
  final String name;
  final List images;
  final int? categoryId;
  final String? category;
  final String? description;

  const Style({
    required this.id,
    required this.name,
    required this.images,
    required this.categoryId,
    required this.category,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, images, description, categoryId];

  factory Style.fromJson(Map<String, dynamic> json) {
    var style = Style(
      id: json['id'],
      name: json['name'],
      images: json['images'],
      category: json['category']!['name'],
      categoryId: json['category_id'] ?? null,
      description: json['description'] ?? '',
    );
    return style;
  }

  String toJson() {
    return json.encode({
      "id": id,
      "name": name,
      "description": description,
      "images": images,
      "category": {
        'name': category
      },
      "category_id": categoryId,
    });
  }
}
