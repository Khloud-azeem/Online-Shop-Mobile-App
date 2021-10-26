import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // const ProductDetailsScreen({ Key? key }) : super(key: key);
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as String;
    final productId = routeArgs;

    final providerData = Provider.of<ProductsProvider>(
      context,
      listen: false,// not to pdate each time sth change, only the first time
    );
    final selectedProduct = providerData.findProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title),
      ),
      body: Container(),
    );
  }
}
