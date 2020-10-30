import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderful_ties/common/custom_drawer/custom_drawer.dart';
import 'package:wonderful_ties/models/product_manager.dart';
import 'package:wonderful_ties/models/user_manager.dart';
import 'package:wonderful_ties/screens/products/components/product_list_tile.dart';
import 'package:wonderful_ties/screens/products/components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return const Text('Produtos');
              } else {
                return LayoutBuilder(
                    builder: (_, constraints){
                      return GestureDetector(
                        onTap: () async {
                          final search = await showDialog<String>(
                              context: context,
                              builder: (_) => SearchDialog(productManager.search));
                              if(search != null){
                                productManager.search = search;
                            }
                          },
                          child: Container(
                            width: constraints.biggest.width,
                            child: Text(
                              productManager.search,
                              textAlign: TextAlign.center,
                            ),
                          )
                      );
                    }
                );
              }
            }
        ),
        centerTitle: true,
        actions: <Widget> [
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search)
                    );
                    if(search != null){
                      context.read<ProductManager>().search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      productManager.search = '';
                    },
                );
              }
            },
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              if(userManager.adminEnabled){
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    Navigator.of(context).pushNamed('/edit_product');
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(
          builder: (_, productManager, __){
            final filteredProducts = productManager.filteredProducts;
            return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: filteredProducts.length,
                itemBuilder: (_, index){
                  return ProductListTile(filteredProducts[index]);
                }
            );
          }
      ),
    );
  }
}