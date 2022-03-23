import 'package:flutter/material.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('Welcome!'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('Products'),
          onTap: () => Navigator.pushReplacementNamed(context, '/'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('My Orders'),
          onTap: () =>
              Navigator.pushReplacementNamed(context, OrderScreen.routeName),
        )
      ]),
    );
  }
}
