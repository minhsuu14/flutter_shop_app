import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../widgets/order_item.dart';
import '../utils/custom_appbar.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _orderFuture;

  Future _orderObtainFuture() {
    return Provider.of<OrderProvider>(context, listen: false).fetchAndSet();
  }

  @override
  void initState() {
    _orderFuture = _orderObtainFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My orders',
      ),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapshot.hasError) {
            return Text('${dataSnapshot.error}');
          } else {
            return Consumer<OrderProvider>(
              builder: ((_, value, child) => ListView.builder(
                    itemBuilder: (context, i) => OrderItem(ord: value.items[i]),
                    itemCount: value.items.length,
                  )),
            );
          }
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
