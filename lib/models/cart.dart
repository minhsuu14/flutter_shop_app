import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final double quantity;
  final String img;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.img,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addtoCart(
    String productId,
    double price,
    String title,
    String img,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCart) => CartItem(
              id: existingCart.id,
              price: existingCart.price,
              quantity: existingCart.quantity + 1,
              title: existingCart.title,
              img: existingCart.img));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                quantity: 1,
                title: title,
                img: img,
              ));
    }
    notifyListeners();
  }

  double total({double sum = 0}) {
    _items.forEach((key, value) {
      sum += value.price * value.quantity;
    });
    return sum;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (item) => CartItem(
              id: item.id,
              price: item.price,
              quantity: item.quantity - 1,
              title: item.title,
              img: item.img));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
