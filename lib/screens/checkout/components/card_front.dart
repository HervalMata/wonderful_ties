import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wonderful_ties/models/credit_card.dart';
import 'package:wonderful_ties/screens/checkout/components/card_text_field.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CardFront extends StatelessWidget{
  final FocusNode numberfocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finished;
  final CreditCard creditCard;

  CardFront({this.numberfocus, this.dateFocus, this.nameFocus, this.finished, this.creditCard});

  final MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
      mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1')}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(16)
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: const Color(0xFF1B4B52),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: <Widget> [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    CardTextfield(
                      title: 'Número',
                      hint: '0000 0000 0000 0000',
                      textInputType: TextInputType.number,
                      bold: true,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CartaoBancarioInputFormatter()
                      ],
                      validator: (number){
                        if(number.length != 19) return 'Inválido';
                        else if(detectCCType(number) == CreditCardType.unknown)
                          return 'Inválido';
                        return null;
                      },
                      onSubmitted: (_){
                        dateFocus.requestFocus();
                      },
                      focusNode: numberfocus,
                      onSaved: creditCard.setNumber,
                    ),
                    CardTextfield(
                      title: 'Validade',
                      hint: '11/2020',
                      textInputType: TextInputType.number,
                      inputFormatters: [dateFormatter],
                      validator: (date){
                        if(date.length != 7) return 'Inválido';
                        return null;
                      },
                      onSubmitted: (_){
                        nameFocus.requestFocus();
                      },
                      focusNode: dateFocus,
                      onSaved: creditCard.setExpirationDate,
                    ),
                    CardTextfield(
                      title: 'Titular',
                      hint: 'João da Silva',
                      textInputType: TextInputType.number,
                      bold: true,
                      validator: (name){
                        if(name.isEmpty) return 'Inválido';
                        return null;
                      },
                      onSubmitted: (_){
                        finished();
                      },
                      focusNode: nameFocus,
                      onSaved: creditCard.setholder,
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}