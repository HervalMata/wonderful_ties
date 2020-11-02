import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier{
  CartManager cartManager;
  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
  }
  void checkout(){
    _decrementStock();
  }

  void _decrementStock() {

  }
}