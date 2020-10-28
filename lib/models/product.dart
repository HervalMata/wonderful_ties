import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
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

  bool get hasStock => stock > 0;
}