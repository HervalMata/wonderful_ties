import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wonderful_ties/models/address.dart';

class AddressInputField extends StatelessWidget{
  final Address address;
  const AddressInputField(this.address);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    String emptyValidator(String text) =>
         text.isEmpty ? 'Campo obrigatório' : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget> [
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Av. Brasil',
          ),
          validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: <Widget> [
            Expanded(
                child: TextFormField(
                  initialValue: address.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Número',
                    hintText: '123',
                  ),
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (t) => address.number = t,
                ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento',
                  hintText: 'Opcional',
                ),
                onSaved: (t) => address.complement = t,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: address.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro',
            hintText: 'Guanabara',
          ),
          validator: emptyValidator,
          onSaved: (t) => address.district = t,
        ),
        Row(
          children: <Widget> [
             Expanded(
                flex: 3,
                child: TextFormField(
                  enabled: false,
                  initialValue: address.city,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'Campinas',
                  ),
                  validator: emptyValidator,
                  onSaved: (t) => address.city = t,
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'UF',
                  hintText: 'SP',
                  counterText: ''
                ),
                maxLength: 2,
                validator: (e){
                  if(e.isEmpty){
                    return 'Campo obrigatório';
                  } else if (e.length != 2){
                    return 'Inválido';
                  }
                  return null;
                },
                onSaved: (t) => address.state = t,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8,),
        RaisedButton(
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          textColor: Colors.white,
          onPressed: (){

          },
          child: const Text('Calcular Frete'),
        ),
      ],
    );
  }

}