import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/cart_product_model.dart';
import 'package:annapurna/model/product_fetch_model.dart';
import 'package:annapurna/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem extends ConsumerWidget {
  final CartProductModel item;

  const CartItem({Key? key, required this.item}) : super(key: key);

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
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'NPR. ${item.quantity * item.price}',
                    style: TextStyle(color: colorGoldenYellow),
                  )
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      ref.watch(cartProvider).subtractQuantity(item);
                    },
                    icon: Icon(Icons.remove_circle,
                        size: 36, color: Colors.white38)),
                SizedBox(
                  width: 4,
                ),
                Text("${item.quantity}",
                    style: TextStyle(fontSize: 16, color: colorGoldenYellow)),
                SizedBox(
                  width: 4,
                ),
                IconButton(
                    onPressed: () {
                      ref.watch(cartProvider).addQuantity(item);
                    },
                    icon:
                        Icon(Icons.add_circle, size: 36, color: Colors.white38))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
