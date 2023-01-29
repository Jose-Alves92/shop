import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth_model.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/order_list_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/products_list_model.dart';
import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_route.dart';

void main() {
  // min<double>(500.0, 800.0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProxyProvider<AuthModel, ProductsList>(
          create: (_) => ProductsList(),
          update: (ctx, auth, previous) {
            return ProductsList(
                auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<AuthModel, OrderListModel>(
          create: (_) => OrderListModel(),
          update: (context, value, previous) {
            return OrderListModel(
                value.token ?? '', value.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.red,
            ),
            textTheme: const TextTheme(
              headline1: TextStyle(fontFamily: 'Lato'),
              headline2: TextStyle(
                  fontFamily: 'Anton', fontSize: 10, color: Colors.white),
            ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.iOS: CustomPageTransitionsBuilder(),
                TargetPlatform.android: CustomPageTransitionsBuilder(),
              },
            )),
        // home: const ProductsOverviewPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
        },
      ),
    );
  }
}
