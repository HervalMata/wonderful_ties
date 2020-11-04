import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextfield extends StatelessWidget{

  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final TextAlign textAlign;

  CardTextfield({
    this.title,
    this.bold = false,
    this.hint,
    this.textInputType,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.textAlign = TextAlign.start,
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
              if(title != null)
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
                  color: title == null && state.hasError
                  ? Colors.white : Colors.red,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: title == null && state.hasError
                            ? Colors.red.withAlpha(200)
                             : Colors.white.withAlpha(100),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    counterText: '',
                ),
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                onChanged: (text){
                  state.didChange(text);
                },
                maxLength: maxLength,
                textAlign: textAlign,
              )
            ],
          ),
        );
      },
    );
  }
}