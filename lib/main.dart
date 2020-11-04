import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/models/admin_orders_manager.dart';
import 'package:wonderful_ties/models/admin_users_manager.dart';
import 'package:wonderful_ties/models/cart_manager.dart';
import 'package:wonderful_ties/models/home_manager.dart';
import 'package:wonderful_ties/models/stores_manager.dart';
import 'package:wonderful_ties/models/user_manager.dart';
import 'package:wonderful_ties/screens/address/address_screen.dart';
import 'package:wonderful_ties/screens/cart/cart_screen.dart';
import 'package:wonderful_ties/screens/checkout/checkout_screen.dart';
import 'package:wonderful_ties/screens/confirmation/confirmation_screen.dart';
import 'package:wonderful_ties/screens/edit_product/edit_product_screen.dart';
import 'package:wonderful_ties/screens/login/login_screen.dart';
import 'package:wonderful_ties/screens/product/product_screen.dart';
import 'package:wonderful_ties/screens/select_product/select_product_screen.dart';
import 'package:wonderful_ties/screens/signup/signup_screen.dart';
import 'package:wonderful_ties/models/product_manager.dart';

import 'package:wonderful_ties/models/order.dart';
import 'package:wonderful_ties/models/orders_manager.dart';
import 'package:wonderful_ties/models/product.dart';
import 'package:wonderful_ties/screens/base/base_screen.dart';

void main() async {
  runApp(MyApp());
  final response = await CloudFunctions.instance.getHttpsCallable(functionName: 'getUserData').call();
  print(response.data);
  //Firestore.instance.collection('teste').add({'teste': 'teste'});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateAdmin(adminEnabled: userManager.adminEnabled),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'Laços da Cris',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 249, 69, 252),
          scaffoldBackgroundColor: const Color.fromARGB(255, 249, 69, 252),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                      settings.arguments as Product
                  )
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(),
                settings: settings
              );
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AddressScreen()
              );
            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
              );
            case '/edit-product':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/select_product':
              return MaterialPageRoute(
                  builder: (_) => SelectProductScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                      settings.arguments as Order
                  )
              );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
                  settings: settings
              );
          }
        },
      ),
    );
  }
}
