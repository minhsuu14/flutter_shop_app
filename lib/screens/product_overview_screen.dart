import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_item.dart';
import '../widgets/badge.dart';
import '../models/cart.dart';
import '../widgets/custom_appbar.dart';

enum FilterProduct {
  showFavorite,
  showAll,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);
  static const routeName = '/product-overview-screen';

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
      appBar: CustomAppBar(
        title: 'My shop',
        action: <Widget>[
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
          : Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
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
            ),
      drawer: const AppDrawer(),
    );
  }
}
