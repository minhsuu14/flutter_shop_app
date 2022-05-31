import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/auth.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          // navigate to detail screen
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            //favorite product
            builder: ((_, product, child) => IconButton(
                  icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: () =>
                      product.favoriteToggle(auth.token!, auth.userId),
                )),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          trailing: Consumer<CartProvider>(
            //add to cart
            builder: ((_, cart, child) => IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    cart.addtoCart(product.id, product.price, product.title,
                        product.imageUrl);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        'Added to your cart!',
                        textAlign: TextAlign.center,
                      ),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ));
                  },
                )),
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
