import 'package:wonderful_ties/models/cart_product.dart';
import 'package:wonderful_ties/models/product.dart';

class CartManager {
  List<CartProduct> items = [];
  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }
}