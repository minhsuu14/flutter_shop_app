import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? action;
  final Widget? leading;
  final String title;
  bool automaticallyImplyLeading;

  CustomAppBar(
      {Key? key,
      this.action,
      this.leading,
      required this.title,
      this.automaticallyImplyLeading = true})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: Theme.of(context)
          .textTheme
          .headline6!
          .apply(color: Theme.of(context).primaryColor),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.deepOrange),
      automaticallyImplyLeading: true,
      actions: action,
      leading: leading,
      elevation: 10,
      title: Text(title),
      backgroundColor: Colors.white,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
    );
  }
}
