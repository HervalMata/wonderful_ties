import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/home_manager.dart';
import 'package:wonderful_ties/models/product_manager.dart';
import 'package:wonderful_ties/models/section.dart';
import 'package:wonderful_ties/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget{
  final SectionItem item;
  const ItemTile(this.item);
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return GestureDetector(
      onTap: (){
        if(item.product != null){
          final product = context.read<ProductManager>()
              .findProductById(item.product);
          if(product != null){
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing ? (){
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Editar Item'),
                actions: <Widget> [
                  FlatButton(
                      onPressed: (){
                        context.read<Section>().removeItem(item);
                        Navigator.of(context).pop();
                      },
                      textColor: Colors.red,
                      child: const Text('Excluir'),
                  ),
                ],
              );
            }
        );
      } : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String ?
        FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.image,
            fit: BoxFit.cover,
        ) :
        Image.file(
            item.image as File, fit: BoxFit.cover,
        ),
      ),
    );
  }
  
}