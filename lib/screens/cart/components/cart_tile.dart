import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/custom_drawer/custom_icon_button.dart';
import 'package:wonderful_ties/models/cart_product.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);
  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        Consumer<CartProduct>(
                            builder: (_, cartProduct, __){
                              if(cartProduct.hasStock)
                                return Text(
                                  'R\$ ${cartProduct.product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );
                              else
                                return Text(
                                  'Sem estoque suficiente',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.red,
                                  ),
                                );
                            }
                        )
                      ],
                    ),
                  ),
              ),
              Consumer<CartProduct>(
                  builder: (_, cartProduct, __){
                    return Column(
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
                          color: cartProduct.quantity > 1 ?
                          Theme.of(context).primaryColor : Colors.red,
                          onTap: cartProduct.decrement,
                        ),
                      ],
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}