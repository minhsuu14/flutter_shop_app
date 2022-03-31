import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';
import '../widgets/expanded_item.dart';

class OrderItem extends StatefulWidget {
  final Order ord;

  const OrderItem({Key? key, required this.ord}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.ord.amount} \$',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            subtitle: Text(DateFormat.yMMMEd().format(widget.ord.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isExpand = !isExpand;
                });
              },
              icon: isExpand
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_circle_down),
            ),
          ),
          Visibility(
            visible: isExpand,
            child: Column(children: [
              const Divider(),
              Container(
                height: min(widget.ord.products.length * 20 + 15, 100),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  children: widget.ord.products
                      .map((prod) => ExpandItem(prod: prod))
                      .toList(),
                ),
              ),
            ]),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
    );
  }
}
