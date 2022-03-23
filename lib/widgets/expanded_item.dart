import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart.dart';
import 'package:flutter_shop_app/models/product.dart';

class ExpandItem extends StatelessWidget {
  final CartItem prod;
  const ExpandItem({Key? key, required this.prod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              child: Image.network(
                prod.img,
                fit: BoxFit.cover,
                height: 20,
                width: 20,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              child: Text(prod.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
            ),
          ],
        ),
        const SizedBox(
          width: 120,
        ),
        Text(
          '${prod.quantity.toStringAsFixed(0)}x',
          style: TextStyle(color: Colors.grey[500]),
        ),
        Text(
          '${prod.price} \$',
          style: TextStyle(color: Colors.grey[500]),
        ),
      ],
    );
  }
}
