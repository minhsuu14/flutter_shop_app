import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart.dart';

class Order {
  final String id;
  final List<CartItem> products;
  final DateTime date;
  final String amount;

  Order(
      {required this.id,
      required this.date,
      required this.products,
      required this.amount});
}

class OrderProvider with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> products, String total) {
    _items.insert(
        0,
        Order(
            id: DateTime.now().toString(),
            date: DateTime.now(),
            products: products,
            amount: total));
    notifyListeners();
  }
}
