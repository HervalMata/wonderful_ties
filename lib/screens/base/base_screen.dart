import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/custom_drawer/custom_drawer.dart';
import 'package:wonderful_ties/models/page_manager.dart';
import 'package:wonderful_ties/screens/home/home_screen.dart';
import 'package:wonderful_ties/screens/products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView (
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          ProductsScreen(),
          /*Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home2'),
        )
      ),*/
          Scaffold(
             drawer: CustomDrawer(),
             appBar: AppBar(
               title: const Text('Home3'),
            )
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
             title: const Text('Home4'),
            )
        ),
      ],
      ),
    );
  }
}
