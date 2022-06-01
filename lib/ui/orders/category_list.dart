import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/product_fetch_model.dart';
import 'package:annapurna/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({
    Key? key,
    required this.items,
    required this.selectedPosition,
  }) : super(key: key);

  final List<ProductFetchModel> items;
  final int selectedPosition;
  @override
  Widget build(BuildContext context, ref) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(GestureDetector(
        onTap: () {
          ref.read(selectedProvider.state).state = i;
        },
        child: SizedBox(
          child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                items[i].categoryName,
                style: TextStyle(
                    color: selectedPosition == i ? colorVacant : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )),
        ),
      ));
    }
    return Container(
      color: colorLightBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18, right: 18, top: 18),
            child: Text(
              "All Categories",
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
