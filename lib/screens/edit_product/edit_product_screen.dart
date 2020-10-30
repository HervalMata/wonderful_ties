import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/product.dart';

class EditProductScreen extends StatelessWidget{
  final Product product;
  const EditProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anuncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget> [

        ],
      ),
    );
  }
}