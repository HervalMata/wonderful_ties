import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/cart_manager.dart';
import 'package:wonderful_ties/models/product.dart';

import 'order.dart';

class CheckoutManager extends ChangeNotifier{
  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail}) async {
    try {
      await _decrementStock();
    } catch(e){
      onStockFail(e);
      return;
    }
    final orderId = await _getOrderId();
    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();
    await order.save();

  }

  Future<void> _decrementStock() {
    return firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];
      for(final cartProduct in cartManager.items){
        Product product;
        if(productsToUpdate.any((p) => p.id == cartProduct.productId)){
          product = productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(firestore.document('products/${cartProduct.productId}')
          );
          product = Product.fromDocument(doc);
        }
        cartProduct.product = product;
        if(product.stock - cartProduct.quantity < 0){
          productsWithoutStock.add(product);
        } else {
          product.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }
      if(productsWithoutStock.isNotEmpty){
        return Future.error('${productsWithoutStock.length} produto sem estoque');
      }
      for(final product in productsToUpdate){
        tx.update(firestore.document('products/${product.id}'), {});
      }
    });
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