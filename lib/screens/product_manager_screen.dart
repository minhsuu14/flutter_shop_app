import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../models/product_provider.dart';
import '../models/product.dart';
import '../widgets/product_manager_item.dart';
import '../screens/edit_product_screen.dart';
import '../utils/custom_appbar.dart';
import '../utils/button_box.dart';

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
      appBar: CustomAppBar(
        title: 'Product Manager',
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
                  price: products[i].price,
                );
              },
              itemCount: products.length),
          padding: const EdgeInsets.all(10),
        ),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: SquareIconButton(
          icon: Icons.add,
          iconColor: Colors.white,
          width: 50,
          onPressed: () =>
              Navigator.of(context).pushNamed(EditProductScreen.routeName),
          buttonColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
