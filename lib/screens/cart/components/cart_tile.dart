import 'package:flutter/material.dart';
import 'package:wonderful_ties/common/custom_drawer/custom_icon_button.dart';
import 'package:wonderful_ties/models/cart_product.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);
  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: <Widget> [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.network(cartProduct.product.images.first),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      cartProduct.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      'R\$ ${cartProduct.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
          ),
          Column(
            children: <Widget> [
              CustomIconButton(
                iconData: Icons.add,
                color: Theme.of(context).primaryColor,
                onTap: cartProduct.increment,
              ),
              Text(
                '${cartProduct.quantity}',
                style: const TextStyle(fontSize: 20),
              ),
              CustomIconButton(
                iconData: Icons.remove,
                color: Theme.of(context).primaryColor,
                onTap: cartProduct.decrement,
              ),
            ],
          )
        ],
      ),
    );
  }
}