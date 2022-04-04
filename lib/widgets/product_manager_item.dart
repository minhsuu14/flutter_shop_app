import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';

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
                  onPressed: () {},
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
