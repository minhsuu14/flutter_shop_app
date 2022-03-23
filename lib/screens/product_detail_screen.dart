import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static String routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final prodId = ModalRoute.of(context)?.settings.arguments as String; //ID
    final product = productProvider.getById(prodId);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Image.network(product.imageUrl),
              alignment: Alignment.center,
            ),
            Text(
              '${product.price} \$',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
