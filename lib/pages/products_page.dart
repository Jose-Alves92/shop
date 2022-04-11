import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_widget.dart';
import 'package:shop/components/product_item_widget.dart';
import 'package:shop/models/products_list_model.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
          }, icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, index) => Column(
            children: [
              ProductItemWidget(product: products.items[index]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
