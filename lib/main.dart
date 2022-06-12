import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/auth.dart';
import 'package:google_fonts/google_fonts.dart';
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
import './screens/auth_screen.dart';
import 'models/product_provider.dart';
import 'utils/constants.dart';

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
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
          create: (ctx) => ProductProvider('', [], ''),
          update: (ctx, auth, product) => ProductProvider(
              auth.token, product == null ? [] : product.items, auth.userId),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (ctx) => OrderProvider('', [], ''),
          update: (ctx, auth, order) => OrderProvider(
              auth.token, order == null ? [] : order.items, auth.userId),
        ),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: theme.copyWith(textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
          home:
              auth.isAuth ? const ProductOverviewScreen() : const AuthScreen(),
          routes: {
            ProductOverviewScreen.routeName: (ctx) =>
                const ProductOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrderScreen.routeName: (ctx) => const OrderScreen(),
            ProductManagerScreen.routeName: (ctx) =>
                const ProductManagerScreen(),
            EditProductScreen.routeName: (ctx) => const EditProductScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
