import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wonderful_ties/models/cart_product.dart';
import 'package:wonderful_ties/models/product.dart';
import 'package:wonderful_ties/models/user.dart';
import 'package:wonderful_ties/models/user_manager.dart';

class CartManager {
  List<CartProduct> items = [];
  User user;
  void addToCart(Product product){
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.quantity++;
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap());
    }
  }

  void _onItemUpdated(){
    print('atualizado');
  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    if(user != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    items = cartSnap.documents.map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)).toList();
  }
}