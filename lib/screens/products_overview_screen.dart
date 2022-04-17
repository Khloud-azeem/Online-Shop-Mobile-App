import 'package:flutter/material.dart';
import 'package:online_shop/providers/cart_provider.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:online_shop/screens/cart_screen.dart';
import 'package:online_shop/widgets/app_drawer.dart';
import 'package:online_shop/widgets/badge.dart';
import 'package:online_shop/widgets/products_gridview.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favourit,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  // const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouritsOnly = false;

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final cartData = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (context, cartData, childToNotRebuild) {
              return Badge(
                child: childToNotRebuild as Widget,
                value: cartData.itemsQuantitiesCount.toString(),
              );
            },
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourit) {
                  _showFavouritsOnly = true;
                } else {
                  _showFavouritsOnly = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  child: Text('Favourits'),
                  value: FilterOptions.Favourit,
                ),
                const PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ];
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGridView(_showFavouritsOnly),
    );
  }
}
