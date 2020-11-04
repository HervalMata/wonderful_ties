import 'package:flutter/material.dart';
import 'package:wonderful_ties/screens/checkout/components/card_text_field.dart';

class CardFront extends StatelessWidget{
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
                    ),
                    CardTextfield(
                      title: 'Validade',
                      hint: '11/2020',
                      textInputType: TextInputType.number,
                    ),
                    CardTextfield(
                      title: 'Titular',
                      hint: 'João da Silva',
                      textInputType: TextInputType.number,
                      bold: true,
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