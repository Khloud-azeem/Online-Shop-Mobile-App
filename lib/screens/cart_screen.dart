import 'package:flutter/material.dart';
import 'package:online_shop/providers/cart_provider.dart';
import 'package:online_shop/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import 'package:online_shop/widgets/cart_item_tile.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    final orderData = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total Price',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Chip(
                    label: Text(
                      '\$${cartData.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: FlatButton(
              child: Text('Order Now'),
              onPressed: () {
                orderData.addOrder(
                    cartData.items.values.toList(), cartData.totalPrice);
                cartData.clearCart();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, idx) {
                return CartItemTile(
                  id: cartData.items.values.toList()[idx].id,
                  productId: cartData.items.keys.toList()[idx],
                  title: cartData.items.values.toList()[idx].title,
                  price: cartData.items.values.toList()[idx].price,
                  quantity: cartData.items.values.toList()[idx].quantity,
                );
              },
              itemCount: cartData.itemsCount,
            ),
          ),
        ],
      ),
    );
  }
}
