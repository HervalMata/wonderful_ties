import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget{
  final VoidCallback onPressd;
  final String buttonText;
  const PriceCard({this.buttonText, this.onPressd});
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Text(
              'Resumo do Pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                const Text('Subtotal'),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                const Text('Total',
                style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                textColor: Colors.white,
                onPressed: onPressd,
                child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}