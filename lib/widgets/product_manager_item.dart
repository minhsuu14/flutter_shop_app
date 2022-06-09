import 'package:flutter/material.dart';
import 'package:flutter_shop_app/utils/widget_functions.dart';
import '../models/product_provider.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';

class ProductManagerItem extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String title;
  final double price;
  const ProductManagerItem(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.id,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imgUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            addHorizontalSpace(10),
            Container(
              width: size.width * 0.34,
              height: size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: textTheme.subtitle1!.apply(fontWeightDelta: 2),
                    //overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${price.toString()}\$',
                    style: textTheme.subtitle1!
                        .apply(color: COLOR_GREY, fontWeightDelta: 1),
                  ),
                  addVerticalSpace(10),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '4.5/5',
                        style: textTheme.subtitle2!.apply(color: COLOR_ORANGE)),
                    const WidgetSpan(
                        child: Icon(
                      Icons.star,
                      color: COLOR_ORANGE,
                      size: 15,
                    )),
                  ]))
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            EditProductScreen.routeName,
                            arguments: id);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        final product = Provider.of<ProductProvider>(context,
                            listen: false);
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
                                    onPressed: () async {
                                      try {
                                        await product.deleteProduct(id);
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('An error has occured !'),
                                        ));
                                      }
                                      Navigator.of(context).pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                                title: const Text('Alert'),
                                content: const SingleChildScrollView(
                                  child: Text(
                                      'Do you want to remove this product ?'),
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
            )
          ],
        ),
      ),
    );
  }
}
