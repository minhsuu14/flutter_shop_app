import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_item.dart';
import '../widgets/badge.dart';
import '../models/cart.dart';
import '../utils/custom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/widget_functions.dart';

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

  var _sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products =
        _showFavorite ? productProvider.favoriteItems : productProvider.items;
    // text theme
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
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
        body: LayoutBuilder(
          builder: (context, constraints) => _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: constraints.maxHeight,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: CarouselSlider.builder(
                                      itemCount: imagesSlider.length,
                                      itemBuilder: (context, index,
                                              realIndex) =>
                                          buildSliderItem(index, constraints),
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 2),
                                        enlargeCenterPage: true,
                                        onPageChanged: (index, reason) =>
                                            setState(() {
                                          _sliderIndex = index;
                                        }),
                                      )),
                                ),
                                addVerticalSpace(30),
                                buildIndexIndicator(
                                    _sliderIndex, imagesSlider.length),
                              ],
                            ),
                          ),
                          addVerticalSpace(10),
                          const Divider(thickness: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Recommended',
                              style: textTheme.headline5!
                                  .apply(fontWeightDelta: 4),
                            ),
                          ),
                          addVerticalSpace(20),
                          Container(
                            height: constraints.maxHeight * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (ctx, i) =>
                                    ChangeNotifierProvider.value(
                                  value: products[i],
                                  child: const ProductItem(),
                                ),
                                itemCount: products.length,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
        ),
        drawer: const AppDrawer(),
      ),
    );
  }

  Widget buildSliderItem(int index, BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: COLOR_GREY),
      child: Image.asset(
        imagesSlider[index],
        height: constraints.maxHeight * 0.2,
        width: constraints.maxWidth * 0.7,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIndexIndicator(int sliderIndex, int count) =>
      AnimatedSmoothIndicator(
        activeIndex: sliderIndex,
        count: count,
        effect: WormEffect(
          activeDotColor: Theme.of(context).primaryColor,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}
