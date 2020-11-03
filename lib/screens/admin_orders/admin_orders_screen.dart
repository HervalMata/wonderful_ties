import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/custom_drawer/custom_drawer.dart';
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
            if(ordersManager.orders.isEmpty){
              return EmptyCard(
                title: 'Nenhuma venda encontrada',
                iconData: Icons.border_clear,
              );
            }
            return ListView.builder(
                itemCount: ordersManager.orders.length,
                itemBuilder: (_, index){
                  return OrderTile(
                      ordersManager.orders.reversed.toList()[index],
                    showControls: true,
                  );
                }
            );
          }
      ),
    );
  }
}