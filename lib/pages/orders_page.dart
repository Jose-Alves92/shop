import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_component.dart';
import 'package:shop/components/order_component.dart';
import 'package:shop/models/order_list_model.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderListModel orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawerComponent(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, index) => OrderComponent(order: orders.items[index]),
      ),
    );
  }
}
