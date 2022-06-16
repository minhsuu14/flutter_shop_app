import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

SnackBar mySnackBar(BuildContext context, String textContent) {
  final textTheme = Theme.of(context).textTheme;
  return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
            color: COLOR_ORANGE, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                'Great !',
                style: textTheme.subtitle1!
                    .apply(fontWeightDelta: 2, color: Colors.white),
              ),
              Text(
                textContent,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.bodyMedium!.apply(color: Colors.white),
              ),
            ]),
            Positioned(
              right: 0,
              child: SvgPicture.asset(
                'assets/images/buy-discount-shop-7-svgrepo-com.svg',
                width: 50,
                height: 50,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: -28,
              right: -22,
              child: InkWell(
                onTap: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/images/cancel-close-delete-svgrepo-com.svg',
                    height: 20,
                    width: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
}
