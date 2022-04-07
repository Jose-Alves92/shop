import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item_component.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/products_list_model.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid({
    Key? key, required this.showFavoriteOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsList>(context);
    final List<Product> loadedProducts = showFavoriteOnly ? provider.favoriteItems : provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
