import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer_component.dart';
import 'package:shop/components/bedge_component.dart';
import 'package:shop/components/productGrid_component.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text(
                  'Somente Favoritos',
                  style: TextStyle(color: Colors.black),
                ),
                value: FilterOptions.Favorite,
              ),
              const PopupMenuItem(
                child: Text(
                  'Todos',
                  style: TextStyle(color: Colors.black),
                ),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectValue) {
              setState(() {
                if (selectValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: _showFavoriteOnly,
      ),
      drawer: const AppDrawerComponent(),
    );
  }
}
