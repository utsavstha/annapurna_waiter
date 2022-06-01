import 'package:annapurna/controller/product_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productNotifierProvider =
    ChangeNotifierProvider.autoDispose<ProductListController>(
        (ref) => ProductListController());
