import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/models/cart_item_model.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class OrderListModel with ChangeNotifier {
  final String _token;
  final String _userId;
  List<OrderModel> _items = [];

  OrderListModel([this._token = '', this._userId = '', this._items = const []]);

  List<OrderModel> get items {
    return [..._items];
  }


  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<OrderModel> items = [];
  
    final responde = await http.get(Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'));
    if (responde.body == "null") return;
    Map<String, dynamic> data = jsonDecode(responde.body);
    data.forEach((key, value) {
      items.add(
        OrderModel(
          id: key,
          date: DateTime.parse(value['date']),
          total: value['total'],
          products: (value['products'] as List<dynamic>).map((e) {
            return CartItem(id: e['id'], productId: e['productId'], name: e['name'], quantity: e['quantity'], price: e['price']);
          }).toList()
        ),
      );
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values.map((cartItem) => {
              'id': cartItem.id,
              'productId': cartItem.productId,
              'name': cartItem.name,
              'quantity': cartItem.quantity,
              'price': cartItem.price,
            }).toList(),
      }),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      OrderModel(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
