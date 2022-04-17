import 'package:flutter/material.dart'; 
import 'package:online_shop/providers/cart_provider.dart';
import 'package:online_shop/providers/orders_provider.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:online_shop/screens/cart_screen.dart';
import 'package:online_shop/screens/edit_product_screen.dart';
import 'package:online_shop/screens/orders_screen.dart';
import 'package:online_shop/screens/product_details_screen.dart';
import 'package:online_shop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
          // ChangeNotifierProvider.value(
          //   // use this way if the data doesn'y depend on the context, we use it with Grid, List items
          //   value: ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'My Online Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Quicksand',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
