import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/app_theme.dart';
import './models/order.dart';
import './models/cart.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/product_manager_screen.dart';
import './screens/edit_product_screen.dart';
import './providers/product_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final theme = AppTheme.theme;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          ProductManagerScreen.routeName: (ctx) => const ProductManagerScreen(),
          EditProductScreen.routeName: (ctx) => const EditProductScreen(),
        },
      ),
    );
  }
}
