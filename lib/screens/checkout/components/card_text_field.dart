import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTextfield extends StatelessWidget{

  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;

  CardTextfield({this.title, this.bold = false, this.hint, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
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
            )
          ],
        ),
    );
  }
}