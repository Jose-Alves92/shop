import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/order_model.dart';

class OrderListModel with ChangeNotifier {
  final List<OrderModel> _items = [];

  List<OrderModel> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      OrderModel(
        total: cart.totalAmount,
        id: Random().nextDouble().toString(),
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
