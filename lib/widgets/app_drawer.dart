import 'package:flutter/material.dart';
import 'package:online_shop/screens/orders_screen.dart';
import 'package:online_shop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Buy Now!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            title: const Text('Shop'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
            title: const Text('Orders'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
            title: const Text('Manage Products'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
