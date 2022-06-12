import 'package:flutter/material.dart';
import '../screens/product_manager_screen.dart';
import '../screens/order_screen.dart';
import '../models/auth.dart';
import 'package:provider/provider.dart';
import '../utils/custom_appbar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        CustomAppBar(
          title: 'Welcome!',
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
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Manage'),
          onTap: () => Navigator.pushReplacementNamed(
              context, ProductManagerScreen.routeName),
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false).logOut();
            }),
      ]),
    );
  }
}
