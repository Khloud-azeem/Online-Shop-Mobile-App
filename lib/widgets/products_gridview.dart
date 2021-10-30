import 'package:flutter/material.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

// import '../models/product.dart';
import 'package:online_shop/widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool showFavouritsOnly;
  ProductsGridView(this.showFavouritsOnly);

  @override
  Widget build(BuildContext context) {
    final providerData =
        Provider.of<ProductsProvider>(context); //instance of Provider data
    final loadedProducts =
        showFavouritsOnly ? providerData.favouritItems : providerData.items;
    // final favouritProducts = providerData.favouritItems;

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, idx) {
        // return ChangeNotifierProvider(
        //   create: (context)=> loadedProducts[idx],
        return ChangeNotifierProvider.value(
          value: loadedProducts[idx],
          child: ProductItem(
              // id: loadedProducts[idx].id,
              // title: loadedProducts[idx].title,
              // imgUrl: loadedProducts[idx].imgUrl,
              ),
        );
      },
      itemCount: loadedProducts.length,
    );
  }
}
