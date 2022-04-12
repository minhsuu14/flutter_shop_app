import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class ProductManagerItem extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String title;
  const ProductManagerItem(
      {Key? key, required this.imgUrl, required this.title, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    final product =
                        Provider.of<ProductProvider>(context, listen: false);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(context),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                  product.deleteProduct(id);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                            title: const Text('Alert'),
                            content: const SingleChildScrollView(
                              child:
                                  Text('Do you want to remove this product ?'),
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  )),
            ],
          ),
        ),
        title: Text(title),
      ),
    );
  }
}
