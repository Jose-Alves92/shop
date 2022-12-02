import 'package:flutter/material.dart';
import 'package:shop/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              centerTitle: true,
              background: Stack(fit: StackFit.expand, children: [
                Hero(
                  tag: product.id,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 0.08),
                      end: Alignment(0.0, 0.0),
                      colors: [
                        Color.fromRGBO(0 , 0, 0, 0.06),
                        Color.fromRGBO(0 , 0, 0, 0.0),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'R\$ ${product.price}',
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.description,
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ]))
        ],
      ),
    );
  }
}
