import 'dart:convert';

import 'package:annapurna/model/cart_product_model.dart';
import 'package:annapurna/network/http_requests.dart';
import 'package:annapurna/providers/cart_provider.dart';
import 'package:annapurna/utils/api_constants.dart';
import 'package:dio/dio.dart';

import 'package:annapurna/model/product_fetch_model.dart';
import 'package:annapurna/utils/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class ProductListController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';
  bool goBack = false;
  bool success = false;
  int selectedCategory = 0;
  late HttpNetworkRequest httpRequest;
  late List<ProductFetchModel> tableModel;
  late List<CartProductModel> cartModel;
  late ApiResponse apiResponse;
  late ApiResponse apiResponseCart;

  ProductListController() {
    apiResponse = ApiResponse.loading(false);
    apiResponseCart = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
    tableModel = [];
    cartModel = [];
  }

  void setSelectedCategory(int selected) {
    selectedCategory = selected;
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
      //     cartModel); // apiResponseCart = ApiResponse.success(false, cartModel);
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponseCart = ApiResponse.error(false, "Could not Transaction");
    }

    // notifyListeners();
  }

  void getProducts() async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      var response = await httpRequest.getWithAuth(ApiConstants.fetchProducts);
      print(response.runtimeType);
      // final data = json.decode(response);

      response.map((item) {
        tableModel.add(ProductFetchModel.fromJson(item));
      }).toList();

      apiResponse = ApiResponse.success(false, tableModel);
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }

    notifyListeners();
  }

  void delete(String id) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      var response =
          await httpRequest.deletetWithAuth(ApiConstants.getBudgets + "/" + id);

      success = true;
      apiResponse = ApiResponse.success(false, success);

      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }

    notifyListeners();
  }

  void createOrder(int tableId, List<CartProductModel> cartItems) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      List<Map<String, dynamic>> orders = [];
      for (var i = 0; i < cartItems.length; i++) {
        orders.add({
          "id": cartItems[i].id,
          "name": cartItems[i].name,
          "price": cartItems[i].price,
          "quantity": cartItems[i].quantity
        });
      }
      final Map<String, dynamic> data = {
        "tableId": tableId.toString(),
        "orders": orders
      };
      var response =
          await httpRequest.postWithAuth(ApiConstants.createOrder, data);
      if (response['status'] == 'success') {
        success = true;
        goBack = true;
        apiResponse = ApiResponse.success(false, success);
      } else {
        apiResponse = ApiResponse.error(false, "Could not create order");
      }
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not create order");
    }

    notifyListeners();
  }

  void updateOrder(int tableId, List<CartProductModel> cartItems) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      List<Map<String, dynamic>> orders = [];
      for (var i = 0; i < cartItems.length; i++) {
        orders.add({
          "id": cartItems[i].id,
          "name": cartItems[i].name,
          "price": cartItems[i].price,
          "quantity": cartItems[i].quantity
        });
      }
      final Map<String, dynamic> data = {
        "tableId": tableId.toString(),
        "orders": orders
      };
      var response =
          await httpRequest.patchWithAuth(ApiConstants.updateOrder, data);
      if (response['status'] == 'success') {
        success = true;
        goBack = true;
        apiResponse = ApiResponse.success(false, success);
      } else {
        apiResponse = ApiResponse.error(false, "Could not create order");
      }
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not create order");
    }

    notifyListeners();
  }
}
