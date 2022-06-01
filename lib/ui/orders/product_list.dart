import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/product_fetch_model.dart';
import 'package:flutter/material.dart';

import 'food_item.dart';

class ProductList extends StatelessWidget {
  final List<Items> items;
  const ProductList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < items.length; i++) {
      widgets.add(FoodItem(
        item: items[i],
      ));
    }

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      color: colorBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 18),
            child: Text(
              "Products",
              style:
                  TextStyle(color: colorLightBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ],
      ),
    );
  }
}
