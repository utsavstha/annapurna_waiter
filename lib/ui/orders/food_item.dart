import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/cart_product_model.dart';
import 'package:annapurna/model/product_fetch_model.dart';
import 'package:annapurna/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodItem extends ConsumerWidget {
  final Items item;

  const FoodItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      color: colorFoodItemBackground,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'NPR. ${item.price}',
                    style: TextStyle(color: colorGoldenYellow),
                  )
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                ref.watch(cartProvider).addItem(CartProductModel(
                    id: item.id,
                    name: item.name,
                    price: item.price,
                    quantity: 1));
              },
              child: const Text(
                "Add to cart",
                style: TextStyle(color: colorVacant),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colorVacant),
              ),
            )
          ],
        ),
      ),
    );
  }
}
