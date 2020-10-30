import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  Product({this.id, this.name, this.description, this.images}){
    images = images ?? [];
  }

  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    price = document['price'] as num;
    stock = document['stock'] as int;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  String id;
  String name;
  String description;
  num price;
  int stock;
  List<String> images;
  List<dynamic> newImages;

  Product clone() {
    return Product(
      id: id, name: name,
      description: description,
      images: List.from(images),
    );
  }

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, stock: $stock, images: $images, newImages: $newImages}';
  }
}