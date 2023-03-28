import 'package:flutter/cupertino.dart';
import 'package:shop/shop_screens/onboarding_screen.dart';

Widget boardingItem(BoardingModel model) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(
            model.image,
          ),
          fit: BoxFit.contain,
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.description,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
