import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imgUrl,
    this.isFavourite = false,
  });

  void toggleFavouritStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
