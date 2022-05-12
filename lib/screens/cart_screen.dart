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
    final String total = carts.total().toStringAsFixed(2);

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
                  OrderButton(total: total),
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

class OrderButton extends StatefulWidget {
  final String total;
  const OrderButton({Key? key, required this.total}) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<CartProvider>(context);
    return TextButton(
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<OrderProvider>(context, listen: false)
            .addOrder(carts.items.values.toList(), widget.total);
        carts.clear();
        setState(() {
          _isLoading = false;
        });
      },
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Order Now'),
    );
  }
}
