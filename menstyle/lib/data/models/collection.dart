import 'dart:convert';

import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final int id;
  final String name;
  final String image;
  final String description;

  const Collection({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id, name, image, description 
  ];

  factory Collection.fromJson(Map<String, dynamic> json) {
    var collection = Collection(
      id: json['id'],
      name: json['name'],
      image: json['featured_image'],
      description: json['description'],
    );
    return collection;
  }

  String toJson() {
    return json.encode({
      "id": id,
      "name": name,
      "description": description,
      "featured_image": image,
    });
  }

  get cname =>  "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  
}
