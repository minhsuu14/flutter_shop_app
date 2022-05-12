import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import '../widgets/product_manager_item.dart';
import '../screens/edit_product_screen.dart';

class ProductManagerScreen extends StatelessWidget {
  static const routeName = '/product-manager-screen';
  const ProductManagerScreen({Key? key}) : super(key: key);

  Future<void> fetchData(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchProductData();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<Product> products = productProvider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Manager'),
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchData(context),
        child: Padding(
          child: ListView.builder(
              itemBuilder: (_, i) {
                return ProductManagerItem(
                  id: products[i].id,
                  title: products[i].title,
                  imgUrl: products[i].imageUrl,
                );
              },
              itemCount: products.length),
          padding: const EdgeInsets.all(8),
        ),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          '+',
          style: TextStyle(fontSize: 24, color: Colors.white60),
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(EditProductScreen.routeName),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
