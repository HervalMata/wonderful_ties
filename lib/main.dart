import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/models/admin_users_manager.dart';
import 'package:wonderful_ties/models/cart_manager.dart';
import 'package:wonderful_ties/models/home_manager.dart';
import 'package:wonderful_ties/models/user_manager.dart';
import 'package:wonderful_ties/screens/cart/cart_screen.dart';
import 'package:wonderful_ties/screens/login/login_screen.dart';
import 'package:wonderful_ties/screens/product/product_screen.dart';
import 'package:wonderful_ties/screens/signup/signup_screen.dart';
import 'package:wonderful_ties/models/product_manager.dart';

import 'models/product.dart';
import 'screens/base/base_screen.dart';

void main() {
  runApp(MyApp());
  
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
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
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
        initialRoute: '/base',
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
                  builder: (_) => CartScreen()
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen()
              );
          }
        },
      ),
    );
  }
}
