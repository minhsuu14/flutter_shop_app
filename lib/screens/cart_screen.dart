import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_builder.dart';
import '../models/order.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = '/my-cart';

  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<CartProvider>(context);
    final double total = carts.total();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          //total cost
          Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '$total \$',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderProvider>(context, listen: false)
                          .addOrder(
                              carts.items.values.toList(), total.toString());
                      carts.clear();
                    },
                    child: const Text('Order Now'),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.all(10),
          ),
          //List carts
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItemBuilder(
                  id: carts.items.values.toList()[i].id,
                  productId: carts.items.keys.toList()[i],
                  img: carts.items.values.toList()[i].img,
                  title: carts.items.values.toList()[i].title,
                  price: carts.items.values.toList()[i].price,
                  quantity: carts.items.values.toList()[i].quantity),
              itemCount: carts.items.length,
            ),
          )
        ],
      ),
    );
  }
}
