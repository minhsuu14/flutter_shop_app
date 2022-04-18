import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_item.dart';
import '../widgets/badge.dart';
import '../models/cart.dart';

enum FilterProduct {
  showFavorite,
  showAll,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchProductData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products =
        _showFavorite ? productProvider.favoriteItems : productProvider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterProduct filter) {
              if (filter == FilterProduct.showFavorite) {
                setState(() => _showFavorite = true);
              } else {
                setState(() => _showFavorite = false);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('My Favorite'),
                value: FilterProduct.showFavorite,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: FilterProduct.showAll,
              ),
            ],
          ),
          Consumer<CartProvider>(
            //amount of cart
            builder: (_, cart, child) => Badge(
              child: child!,
              value: cart.items.length.toString(),
              color: Colors.redAccent,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: const ProductItem(),
              ),
              itemCount: products.length,
            ),
      drawer: const AppDrawer(),
    );
  }
}
