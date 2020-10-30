import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/product.dart';

class ImagesForm extends StatelessWidget{
  final Product product;

  const ImagesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
        builder: (state) {

        },
    );
  }

}