import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  num price;
  int stock;
  List<String> images;
  List<dynamic> newImages;

  bool deleted;
  bool _loading = false;
  bool get loading => _loading;
  bool get hasStock => stock > 0 && !deleted;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  num get basePrice {
    num lowest = double.infinity;
    if(price <lowest) lowest = price;
    return lowest;
  }

  Product({this.id, this.name, this.description, this.images, this.deleted = false}){
    images = images ?? [];
  }

  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    price = document['price'] as num;
    stock = document['stock'] as int;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    deleted = (document.data['deleted'] ?? false) as bool;
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  Product clone() {
    return Product(
      id: id, name: name,
      description: description,
      images: List.from(images),
      deleted: deleted,
    );
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'deleted': deleted,
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

    for(final image in images){
      if(!newImages.contains(image) && image.contains('firebase')){
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});
    images = updateImages;
    loading = false;
  }
  
  void delete() {
    firestoreRef.updateData({'deleted': true});
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, stock: $stock, images: $images, newImages: $newImages}';
  }
}