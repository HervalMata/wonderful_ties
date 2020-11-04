import 'package:flutter/material.dart';
import 'package:wonderful_ties/common/custom_icon_button.dart';
import 'package:wonderful_ties/models/store.dart';

class StoreCard extends StatelessWidget{
  final Store store;
  const StoreCard(this.store);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: <Widget> [
          Image.network(store.image),
          Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget> [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Text(
                          store.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          store.addressText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          store.openingText,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    CustomIconButton(
                      iconData: Icons.map,
                      color: primaryColor,
                      onTap: (){

                      },
                    ),
                    CustomIconButton(
                      iconData: Icons.phone,
                      color: primaryColor,
                      onTap: (){

                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}