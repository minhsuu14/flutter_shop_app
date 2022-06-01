import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product_provider.dart';
import '../utils/button_box.dart';
import '../utils/constants.dart';
import '../utils/widget_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static String routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final prodId = ModalRoute.of(context)?.settings.arguments as String; //ID
    final product = productProvider.getById(prodId);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return Container(
              height: constraints.maxHeight,
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.4,
                            decoration: const BoxDecoration(
                              color: Color(0xffE2F3D4),
                            ),
                            child: Center(
                              child: Image.network(
                                product.imageUrl,
                                width: constraints.maxWidth * 0.5,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: SquareIconButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(context),
                              width: 50,
                              icon: Icons.arrow_back_ios_outlined,
                              iconColor: Colors.orange,
                              buttonColor: Colors.orange.shade100,
                            ),
                          ),
                        ],
                      ),
                      //Back button & product image
                      addVerticalSpace(10),
                      Container(
                        color: Colors.grey.shade50,
                        child: Stack(clipBehavior: Clip.none, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //color: Colors.red,
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.title,
                                                style: textTheme.headline6!
                                                    .apply(fontWeightDelta: 4),
                                              ),
                                              addVerticalSpace(5),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const WidgetSpan(
                                                      child: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.red,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Ho Chi Minh city',
                                                      style: textTheme
                                                          .subtitle2!
                                                          .apply(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                        RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                              const TextSpan(
                                                  text: '\$',
                                                  style: TextStyle(
                                                      color: COLOR_ORANGE)),
                                              TextSpan(
                                                text: product.price.toString(),
                                                style: textTheme.headline5!
                                                    .apply(
                                                        color: COLOR_ORANGE,
                                                        fontWeightDelta: 4),
                                              )
                                            ]))
                                      ]),
                                ),
                                addVerticalSpace(20),
                                const Divider(),
                                addVerticalSpace(20),
                                Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                            text: TextSpan(children: [
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 15,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '4.5',
                                            style: textTheme.subtitle2!
                                                .apply(fontWeightDelta: 4),
                                          )
                                        ])),
                                        RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                              const WidgetSpan(
                                                  child: Icon(
                                                Icons.access_time_outlined,
                                                color: Colors.red,
                                                size: 15,
                                              )),
                                              TextSpan(
                                                  text: '3 days',
                                                  style: textTheme.subtitle2!
                                                      .apply(
                                                          fontWeightDelta: 4))
                                            ])),
                                        RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(children: [
                                              const WidgetSpan(
                                                  child: Icon(
                                                Icons.location_on,
                                                size: 15,
                                                color: Colors.green,
                                              )),
                                              TextSpan(
                                                  text: '5 km',
                                                  style: textTheme.subtitle2!
                                                      .apply(
                                                          fontWeightDelta: 4))
                                            ])),
                                      ]),
                                ),
                                addVerticalSpace(20),
                                const Divider(),
                                addVerticalSpace(10),
                                Text(
                                  'Overview',
                                  style: textTheme.headline5!
                                      .apply(fontWeightDelta: 2),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  product.description,
                                  style: textTheme.subtitle2!
                                      .apply(heightDelta: 2),
                                ),
                                addVerticalSpace(100),
                              ],
                            ),
                          ),
                          Positioned(
                              top: -35,
                              right: 20,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(18),
                                ),
                              )),
                        ]),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                      color: Colors.grey.shade50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: constraints.maxWidth,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareIconButton(
                              icon: Icons.shopping_bag,
                              onPressed: () {},
                              buttonColor: COLOR_ORANGE,
                              iconColor: Colors.white,
                            ),
                            addHorizontalSpace(30),
                            Text(
                              'Add to cart',
                              style: textTheme.headline4!
                                  .apply(color: COLOR_ORANGE),
                            )
                          ])),
                )
              ]),
            );
          }),
        ),
      ),
    );
  }
}
