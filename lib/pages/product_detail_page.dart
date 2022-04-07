import 'package:flutter/material.dart';
import 'package:shop/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(product.imageUrl, fit: BoxFit.cover,),
          ),
          const SizedBox(height: 10),
          Text('R\$ ${product.price}',
          style: const TextStyle(color: Colors.grey, fontSize: 20),
          textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10,),
          Text(product.description, style: const TextStyle(color: Colors.black), textAlign: TextAlign.center,),
        ],
      ),),
    );
  }
}
