import 'package:annapurna/model/cart_product_model.dart';
import 'package:annapurna/model/product_fetch_model.dart';
import 'package:annapurna/network/http_requests.dart';
import 'package:annapurna/ui/orders/cart_item.dart';
import 'package:annapurna/utils/api_constants.dart';
import 'package:annapurna/utils/api_response.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  var cartItems = <CartProductModel>[];
  var items = <CartProductModel>[];

  bool isLoading = true;

  String message = '';

  late HttpNetworkRequest httpRequest;
  late List<CartProductModel> cartModel;
  late ApiResponse apiResponseCart;

  CartController() {
    apiResponseCart = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
    cartModel = [];
  }
  void getItems() {
    // notifyListeners();
  }

  void addAll(List<CartProductModel> items) {
    print("called");
    for (var i = 0; i < items.length; i++) {
      addItem(items[i]);
    }
  }

  void addItem(CartProductModel item) {
    var contain = cartItems.where((element) => element.id == item.id);
    if (contain.isEmpty) {
      cartItems.add(item);
      items.add(item);
    } else {
      addQuantity(item);
      // addQuantity(item);
    }

    notifyListeners();
  }

  void deleteItem(CartProductModel item) {
    cartItems.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }

  void addQuantity(CartProductModel item) {
    for (var i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == item.id) {
        cartItems[i].quantity += 1;
        items[i].quantity += 1;
      }
    }

    notifyListeners();
  }

  void subtractQuantity(CartProductModel item) {
    var lastIndex = -1;
    for (var i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == item.id) {
        if (cartItems[i].quantity - 1 > 0) {
          cartItems[i].quantity -= 1;
        }
        lastIndex = i;

        items[i].quantity -= 1;
      }
    }
    // items.clear();
    // for (var i = 0; i < cartItems.length; i++) {
    //   if (cartItems[i].quantity > 0) {
    //     items.add(cartItems[i]);
    //   }
    // }

    // print(items.length);

    if (lastIndex != -1 && items[lastIndex].quantity <= 0) {
      items.remove(items[lastIndex]);
    }
    // getItems();
    notifyListeners();
  }

  void getCart(int tableId) async {
    apiResponseCart = ApiResponse.loading(true);
    // notifyListeners();

    try {
      var response =
          await httpRequest.getWithAuth(ApiConstants.order + "/$tableId");
      // print(response.runtimeType);
      // final data = json.decode(response);

      response.map((item) {
        cartModel.add(CartProductModel.fromJson(item));
      }).toList();
      // print("getcart");
      // ref.watch(cartProvider).addAll(
      // cartModel);
      // apiResponseCart = ApiResponse.success(false, cartModel);
      addAll(cartModel);
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponseCart = ApiResponse.error(false, "Could not Transaction");
    }

    // notifyListeners();
  }
}
