import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier{
  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
  }
  void checkout(){
    _decrementStock();
    _getOrderId().then((value) => print(value));
  }

  void _decrementStock() {

  }

  Future<int> _getOrderId() async {
    final ref = firestore.document('aux/ordercount');
    try{
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data['current'] as int;
        await tx.update(ref, {'current': orderId +1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch(e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }
}