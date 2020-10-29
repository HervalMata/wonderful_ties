import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/section.dart';
import 'package:wonderful_ties/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget{
  final Section section;
  const SectionList(this.section);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          SectionHeader(section),
        ],
      ),
    );
  }
}