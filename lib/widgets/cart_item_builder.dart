import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartItemBuilder extends StatelessWidget {
  final String id;
  final String productId;
  final String img;
  final String title;
  final double quantity;
  final double price;

  const CartItemBuilder(
      {Key? key,
      required this.id,
      required this.productId,
      required this.img,
      required this.title,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => cart.removeItem(productId),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: const Text(
                    'Do you want to remove this item from your cart ?'),
                title: const Text('Alert'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('No')),
                ],
              );
            });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: Container(
            height: double.infinity,
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(title),
          subtitle: Text("Quantity: $quantity"),
          trailing: Text(
            '$price \$',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
