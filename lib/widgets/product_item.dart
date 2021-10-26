import 'package:flutter/material.dart';
import 'package:online_shop/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem({Key? key}) : super(key: key);

  // final String id;
  // final String title;
  // final String imgUrl;

  // ProductItem({
  //   required this.id,
  //   required this.title,
  //   required this.imgUrl,
  // });

  // void selectProduct(BuildContext context) {
  //   Navigator.of(context)
  //       .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
  // }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ProductDetailsScreen.routeName,
          arguments: product.id,
        ),
        child: Image.network(
          product.imgUrl,
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
              // lable: child
              onPressed: () => product.toggleFavouritStatus(),
            );
            // child: Text(''), // this don't rebuild when consumer rebuilds its content
          },
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.shopping_cart,
          ),
          color: Theme.of(context).accentColor,
          onPressed: null,
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
