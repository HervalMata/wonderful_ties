import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextfield extends StatelessWidget{

  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;

  CardTextfield({
    this.title,
    this.bold = false,
    this.hint,
    this.textInputType,
    this.inputFormatters,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      validator: validator,
      builder: (state){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Row(
                children: <Widget> [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  if(state.hasError)
                    const Text(
                      '  Inválido',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
              TextFormField(
                style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.white.withAlpha(100),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2)
                ),
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                onChanged: (text){
                  state.didChange(text);
                },
              )
            ],
          ),
        );
      },
    );
  }
}