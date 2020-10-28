import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/models/user_manager.dart';
import 'package:wonderful_ties/screens/login/login_screen.dart';
import 'package:wonderful_ties/screens/signup/signup_screen.dart';
import 'package:wonderful_ties/models/product_manager.dart';

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
        )
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
