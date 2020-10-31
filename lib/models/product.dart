import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

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

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
    };
    if(id == null){
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    final List<String> updateImages = [];

    for(final newImage in newImages){
      if(images.contains(newImage)){
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }
  }
  


  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, stock: $stock, images: $images, newImages: $newImages}';
  }
}