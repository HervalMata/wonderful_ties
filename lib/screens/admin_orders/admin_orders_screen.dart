import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/custom_drawer/custom_drawer.dart';
import 'package:wonderful_ties/common/custom_icon_button.dart';
import 'package:wonderful_ties/common/empty_card.dart';
import 'package:wonderful_ties/common/order/order_tile.dart';
import 'package:wonderful_ties/models/admin_orders_manager.dart';


class AdminOrdersScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Todos os Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrdersManager>(
          builder: (_, ordersManager, __){
            final filteredOrders = ordersManager.fiteredOrders;
            return Column(
              children: <Widget> [
                if(ordersManager.userFilter != null)
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                      child: Row(
                        children: <Widget> [
                          Expanded(
                              child: Text(
                                'Pedidos de ${ordersManager.userFilter.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                          ),
                          CustomIconButton(
                            iconData: Icons.close,
                            color: Colors.white,
                            onTap: (){
                              ordersManager.setUserFilter(null);
                            },
                          )
                        ],
                      ),
                  ),
                if(filteredOrders.isEmpty)
                  Expanded(
                      child: EmptyCard(
                        title: 'Nenhuma venda realizada!',
                        iconData: Icons.border_clear,
                      ),
                  )
                else
                  Expanded(
                      child: ListView.builder(
                          itemCount: filteredOrders.length,
                          itemBuilder: (_, index){
                            return OrderTile(
                              filteredOrders[index],
                              showControls: true,
                            );
                          }
                      ),
                  )
              ],
            );
          },
      ),
    );
  }
}