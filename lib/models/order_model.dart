import 'package:shop/models/cart_item_model.dart';

class OrderModel {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  const OrderModel({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}