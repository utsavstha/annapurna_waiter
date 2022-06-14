import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/cart_product_model.dart';
import 'package:annapurna/providers/cart_provider.dart';
import 'package:annapurna/ui/orders/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//
class CartList extends ConsumerStatefulWidget {
  final int tableId;
  final String tableStatus;
  CartList({Key? key, required this.tableId, required this.tableStatus})
      : super(key: key);

  @override
  ConsumerState<CartList> createState() => _CartListState();
}

class _CartListState extends ConsumerState<CartList> {
  @override
  void initState() {
    super.initState();
    if (widget.tableStatus == "occupied") {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        ref.read(cartProvider).getCart(widget.tableId);
      });
    }
  }

  List<Widget> _buildCartItems(List<CartProductModel> items) {
    List<Widget> widgets = [];

    for (var i = 0; i < items.length; i++) {
      widgets.add(CartItem(item: items[i]));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      color: colorBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 18),
            child: Text(
              "Cart",
              style:
                  TextStyle(color: colorLightBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final provider = ref.watch(cartProvider);

            return ListView(
                shrinkWrap: true, children: _buildCartItems(provider.items));
          }),
        ],
      ),
    );
  }
}
