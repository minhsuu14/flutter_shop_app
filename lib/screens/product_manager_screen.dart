import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import '../widgets/product_manager_item.dart';

class ProductManagerScreen extends StatelessWidget {
  static const routeName = '/product-manager-screen';
  const ProductManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<Product> products = productProvider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Manager'),
      ),
      body: Padding(
        child: ListView.builder(
            itemBuilder: (_, i) {
              return ProductManagerItem(
                title: products[i].title,
                imgUrl: products[i].imageUrl,
              );
            },
            itemCount: products.length),
        padding: const EdgeInsets.all(8),
      ),
      drawer: const AppDrawer(),
    );
  }
}
