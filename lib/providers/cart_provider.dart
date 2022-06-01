import 'package:annapurna/controller/cart_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = ChangeNotifierProvider.autoDispose<CartController>(
    (ref) => CartController());

final selectedProvider = StateProvider.autoDispose<int>((ref) => 0);
