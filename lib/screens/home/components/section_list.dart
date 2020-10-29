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
          SizedBox(
            height: 150,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index){
                  return AspectRatio(
                      aspectRatio: 1,
                    child: Image.network(
                      section.items[index].image,
                      fit: BoxFit.cover,
                    )
                  );
                },
                separatorBuilder: (_, __ ) => const SizedBox(width: 4,),
                itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}