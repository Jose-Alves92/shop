import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list_model.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawerWidget(),
      body: FutureBuilder(
        future: Provider.of<OrderListModel>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<OrderListModel>(
              builder: (ctx, orders, child) => ListView.builder(
                itemCount: orders.items.length,
                itemBuilder: (ctx, index) =>
                    OrderWidget(order: orders.items[index]),
              ),
            );
          }
        },
      ),
    );
  }
}

       