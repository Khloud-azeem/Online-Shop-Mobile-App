import 'package:flutter/material.dart';
import 'package:online_shop/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:online_shop/providers/cart_provider.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.price,
    required this.products,
    required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get items {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double price) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        price: price,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners(); // to insert the iorder in the begining of the list
  }
}
