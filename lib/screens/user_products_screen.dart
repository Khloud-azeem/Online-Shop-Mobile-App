import 'package:flutter/material.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:online_shop/widgets/user_products_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
      ),
      body: ListView.builder(
        itemBuilder: (context, idx) {
          return Column(
            children: <Widget>[
              UserProductsItem(
                  title: productsData.items[idx].title,
                  imgUrl: productsData.items[idx].imgUrl),
              Divider(),
            ],
          );
        },
        itemCount: productsData.items.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
