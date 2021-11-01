import 'package:flutter/material.dart';
import 'package:online_shop/providers/orders_provider.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:online_shop/widgets/order_item_tile.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, idx) {
          return OrderItemTile(orderData.items[idx]);
        },
        itemCount: orderData.items.length,
      ),
      drawer: AppDrawer(), backgroundColor: Colors.white,
    );
  }
}
