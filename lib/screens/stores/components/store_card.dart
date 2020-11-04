import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wonderful_ties/common/custom_icon_button.dart';
import 'package:wonderful_ties/models/store.dart';

class StoreCard extends StatelessWidget{
  final Store store;
  const StoreCard(this.store);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    Color colorForStatus(StoreStatus status){
      switch(status) {
        case StoreStatus.closed:
          return Colors.red;
          break;
        case StoreStatus.open:
          return Colors.green;
          break;
        case StoreStatus.closing:
          return Colors.orange;
          break;
        default:
          return Colors.green;
      }
    }

    Future<void> openPhone() async {
      if(await canLaunch('tel:${store.clearPhone}')){
        launch('tel:${store.clearPhone}');
      } else {
        Scaffold.of(context).showSnackBar(
          const SnackBar(
              content: Text('Esta função não está disponivél neste dispositivo'),
              backgroundColor: Colors.red,
          )
        );
      }
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget> [
          Container(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget> [
                Image.network(
                    store.image,
                    fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8)
                      )
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: colorForStatus(store.status),
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      onTap: openPhone,
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