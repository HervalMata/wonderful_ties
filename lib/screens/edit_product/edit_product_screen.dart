import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/product.dart';
import 'package:wonderful_ties/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget{
  final Product product;
  final bool editing;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditProductScreen(Product p) :
        editing = p != null,
        product = p != null ? p.clone() : Product();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget> [
            ImagesForm(product),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget> [
                    TextFormField(
                      initialValue: product.name,
                      decoration: const InputDecoration(
                        hintText: 'Titulo',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                      validator: (name){
                        if(name.length < 6) return 'Titulo muito curto';
                        return null;
                      },
                      onSaved: (name) => product.name = name,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'A partir de',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                          ),
                        ),
                    ),
                    Text(
                      'R\$ ...',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description,
                      style: TextStyle(
                          fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      validator: (desc){
                        if(desc.length < 10) return 'Descrição muito curta';
                        return null;
                      },
                      onSaved: (desc) => product.description = desc,
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: (){
                          if(formKey.currentState.validate()){
                            product.save();
                          }
                        },
                        textColor: Colors.white,
                        color: primaryColor,
                        disabledColor: primaryColor.withAlpha(100),
                        child: const Text(
                            'Salvar',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ),
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}