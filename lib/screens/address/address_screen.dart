import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/price_card.dart';
import 'package:wonderful_ties/models/cart_manager.dart';

class AddressScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget> [
          AddressScreen(),
          Consumer<CartManager>(
              builder: (_, cartManager, __){
                return PriceCard(
                  buttonText: 'Continuar para o Pagamento',
                  onPressd: cartManager.isAddressvalid ? (){

                  } : null,
                );
              }
          )
        ]
      ),
    );
  }
}