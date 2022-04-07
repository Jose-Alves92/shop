import 'package:flutter/material.dart';
import 'package:shop/models/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  final Product products;
  const ProductItemWidget({ Key? key, required this.products }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundImage: NetworkImage(products.imageUrl),
      ),
      title: Text(products.name, style: const TextStyle(color: Colors.black),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  
                },
              ),
            IconButton(
                icon: const Icon(Icons.delete, color: Colors.red,),
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }
}