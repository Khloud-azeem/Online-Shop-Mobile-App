import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/providers/orders_provider.dart';
import 'dart:math';

import 'package:online_shop/providers/product.dart';

class OrderItemTile extends StatefulWidget {
  final OrderItem order;
  OrderItemTile(this.order);

  @override
  State<OrderItemTile> createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Price \$${widget.order.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Date ${DateFormat('dd-MM-yyyy').format(widget.order.dateTime)}'),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView(
                  // builder didn't work
                  children: widget.order.products
                      .map(
                        (product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('\$${product.price} X ${product.quantity}'),
                          ],
                        ),
                      )
                      .toList()),
            ),
        ],
      ),
    );
  }
}
