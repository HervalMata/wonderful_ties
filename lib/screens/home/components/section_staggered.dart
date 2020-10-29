import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/section.dart';
import 'package:wonderful_ties/screens/home/components/section_header.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SectionStaggered extends StatelessWidget{
  final Section section;
  const SectionStaggered(this.section);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (_, index){
              return Image.network(
                  section.items[index].image,
                fit: BoxFit.cover,
              );
            },
            staggeredTileBuider: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          )
        ],
      ),
    );
  }
}