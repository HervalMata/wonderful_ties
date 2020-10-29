import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/section.dart';

class SectionHeader extends StatelessWidget{
  final Section section;
  const SectionHeader(this.section);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}