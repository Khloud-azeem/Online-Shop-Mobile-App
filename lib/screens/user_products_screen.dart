import 'package:flutter/material.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:online_shop/widgets/user_products_item.dart';
import 'package:provider/provider.dart';
import 'package:online_shop/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemBuilder: (context, idx) {
            return Column(
              children: <Widget>[
                UserProductsItem(
                    title: productsData.items[idx].title,
                    imgUrl: productsData.items[idx].imgUrl),
                const Divider(),
              ],
            );
          },
          itemCount: productsData.items.length,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
