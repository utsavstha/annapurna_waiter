import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/cart_product_model.dart';
import 'package:annapurna/model/product_fetch_model.dart';
import 'package:annapurna/providers/cart_provider.dart';
import 'package:annapurna/providers/dashboard_provider.dart';
import 'package:annapurna/providers/product_with_category_provider.dart';
import 'package:annapurna/ui/custom_widgets/admin_dropdown.dart';
import 'package:annapurna/ui/custom_widgets/dropdown_widget.dart';
import 'package:annapurna/utils/no_data.dart';
import 'package:annapurna/utils/progress_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_list.dart';
import 'category_list.dart';
import 'product_list.dart';

class TakeOrder extends ConsumerStatefulWidget {
  const TakeOrder({Key? key}) : super(key: key);

  @override
  ConsumerState<TakeOrder> createState() => _TakeOrderState();
}

class _TakeOrderState extends ConsumerState<TakeOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(productNotifierProvider).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final tableId = args['tableId'] as int;
    final tableStatus = args['status'] as String;
    if (tableStatus == "occupied") {
      print('order for table');
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        ref.read(productNotifierProvider).getCart(tableId);
      });
    }
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    color: colorBackgroundDark,
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon:
                                  Icon(Icons.arrow_back, color: Colors.white)),
                          AdminDropDownStatefulWidget()
                        ],
                      ),
                    ),
                  ),
                  Consumer(builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final provider = ref.watch(productNotifierProvider);

                    if (provider.apiResponse.isLoading) {
                      return const ProgressDialog();
                    }
                    if (provider.goBack) {
                      WidgetsBinding.instance!
                          .addPostFrameCallback((timeStamp) {
                        ref.read(dashboardNotifierProvider).getTables();
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Your order has been placed successfully',
                          btnOkOnPress: () {
                            Navigator.of(context).pop();
                          },
                        ).show();
                      });
                      return const ProgressDialog();
                    }

                    if (provider.apiResponse.model == null ||
                        (provider.apiResponse.model as List<ProductFetchModel>)
                            .isEmpty) {
                      return const NoData();
                    } else {
                      final data = (provider.apiResponse.model
                          as List<ProductFetchModel>);

                      return Consumer(builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final selected = ref.watch(selectedProvider);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 2,
                                child: CategoryList(
                                  items: data,
                                  selectedPosition: selected,
                                )),
                            Expanded(
                              flex: 6,
                              child: ProductList(
                                items: data[selected].items,
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: CartList(
                                    tableId: tableId,
                                    tableStatus: tableStatus)),
                          ],
                        );
                      });
                    }
                  }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () {
                      if (tableStatus == "occupied") {
                        ref.read(productNotifierProvider).updateOrder(
                            tableId, ref.read(cartProvider).cartItems);
                      } else {
                        ref.read(productNotifierProvider).createOrder(
                            tableId, ref.read(cartProvider).cartItems);
                      }
                    },
                    child: const Text(
                      "Place Order",
                      style: TextStyle(color: colorReserved),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorReserved),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
