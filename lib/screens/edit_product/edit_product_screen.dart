import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/product.dart';
import 'package:wonderful_ties/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget{
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anuncio'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget> [
            ImagesForm(product),
            RaisedButton(
                onPressed: (){
                  if(formKey.currentState.validate()){
                    print('válido!!!');
                  }
                },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}