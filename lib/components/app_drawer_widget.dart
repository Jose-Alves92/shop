import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth_model.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_route.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem Vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(builder: ((context) => const OrdersPage())),
              // );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar Produtos',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Gerenciar Produtos',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Provider.of<AuthModel>(context, listen: false).logout();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          )
        ],
      ),
    );
  }
}
