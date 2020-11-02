import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/product.dart';

class CartProduct extends ChangeNotifier {

  CartProduct.fromProduct(this._product){
    productId = product.id;
    quantity = 1;
  }
  
  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    firestore.document('products/$productId').get().then(
         (doc) {
              product = Product.fromDocument(doc);
         }
    );
  }

  final Firestore firestore = Firestore.instance;

  String id;
  String productId;
  int quantity;
  Product _product;
  Product get product => _product;

  set product(Product value) {
    _product = value;
    notifyListeners();
  }

  num get unitPrice {
    if(product == null) return 0;
    return product?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
    };
  }

  bool stackable(Product product){
    return product.id == productId;
  }

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    if(product == null) return false;
    return product.stock >= quantity;
  }

}