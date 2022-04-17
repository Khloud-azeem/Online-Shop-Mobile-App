import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouritItems {
    return _items.where((item) => item.isFavourite).toList();
  }

  Future<void> addProduct(Product product) {
    final url =
        Uri.parse("https://online-shop-5e10b-default-rtdb.firebaseio.com");
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imgUrl': product.imgUrl,
              'price': product.price,
              'isFavourite': product.isFavourite,
            }))
        .then((response) {
      _items.add(Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        imgUrl: product.imgUrl,
      ));
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw (error);
    });
  }

  void removeItem(String productId) {
    _items.removeWhere((product) => product.id == productId);
  }

  Product findProductById(String productId) {
    return _items.firstWhere((product) => product.id == productId);
  }
}
