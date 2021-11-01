import 'package:flutter/material.dart';
import 'package:online_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  // const CartItemTile({ Key? key }) : super(key: key);

  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItemTile({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      background: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          // size: 20,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: ListTile(
          leading: CircleAvatar(child: Text('${quantity}X')),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('total \$${(price * quantity)}'),
          trailing: Text('\$$price'),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            actions: [
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
