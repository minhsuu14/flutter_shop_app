import 'package:flutter/material.dart';

class ProductManagerItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  const ProductManagerItem(
      {Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
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
