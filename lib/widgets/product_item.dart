import 'package:flutter/material.dart';
import 'package:online_shop/providers/cart_provider.dart';
import 'package:online_shop/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:online_shop/providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<CartProvider>(context, listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ProductDetailsScreen.routeName,
          arguments: productData.id,
        ),
        child: Image.network(
          productData.imgUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        leading: Consumer<Product>(
          builder: (context, product, child) {
            return IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              //doesn't work???????
              color: Theme.of(context).accentColor,
              onPressed: () => product.toggleFavouritStatus(),
            );
          },
        ),
        trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cartData.addItem(
                  productData.id, productData.title, productData.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Product added to the cart'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartData.removeThisItem(productData.id);
                    },
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }),
        title: Text(
          productData.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
