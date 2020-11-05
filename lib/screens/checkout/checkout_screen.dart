import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/price_card.dart';
import 'package:wonderful_ties/models/cart_manager.dart';
import 'package:wonderful_ties/models/checkout_manager.dart';
import 'package:wonderful_ties/models/credit_card.dart';
import 'package:wonderful_ties/screens/checkout/components/cpf_field.dart';
import 'package:wonderful_ties/screens/checkout/components/credit_card_widget.dart';

class CheckoutScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CreditCard creditCard = CreditCard();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __) {
              if(checkoutManager.loading){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                      ),
                      const SizedBox(height: 165,),
                      Text(
                          'Processando seu pagamento...',
                           style: TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.w800,
                             fontSize: 16
                           ),
                      )
                    ],
                  ),
                );
              }
              return Form(
                key: formKey,
                child: ListView(
                  children: <Widget> [
                    CreditCardWidget(creditCard),
                    CpfField(),
                    PriceCard(
                      buttonText: 'Finalizar Pedido',
                      onPressd: (){
                        if(formKey.currentState.validate());
                        checkoutManager.checkout(
                          creditCard: creditCard,
                          onStockFail: (e){
                            Navigator.of(context).popUntil((route) => route.settings.name == '/cart');
                          },
                          onPayFail: (e){
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('$e'),
                                backgroundColor: Colors.red,
                              )
                            );
                          },
                          onSuccess: (order){
                            Navigator.of(context).popUntil((route) => route.settings.name == '/');
                            Navigator.of(context).pushNamed('/confirmation', arguments: order);
                          }
                        );
                      },
                    )
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}