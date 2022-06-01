import 'dart:convert';

import 'package:annapurna/model/notification_model.dart';
import 'package:annapurna/network/http_requests.dart';
import 'package:annapurna/utils/api_constants.dart';
import 'package:dio/dio.dart';

import 'package:annapurna/model/table_model.dart';
import 'package:annapurna/utils/api_response.dart';
import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';

  bool success = false;
  late HttpNetworkRequest httpRequest;
  late List<TableModel> tableModel;
  late List<TableModel> pollTableModel;
  late List<Notifications> notificationModel;
  late List<Notifications> pollNotificationModel;
  late ApiResponse apiResponse;
  late ApiResponse apiResponseNotification;

  DashboardController() {
    apiResponse = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
    tableModel = [];
    notificationModel = [];
  }

  void getTables() async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      var response = await httpRequest.getWithAuth(ApiConstants.getTables);
      // print(response.runtimeType);
      // final data = json.decode(response);
      tableModel = [];
      response = response['data'];
      response.map((item) {
        tableModel.add(TableModel.fromJson(item));
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

  void pollNotifications() async {
    try {
      var response = await httpRequest.getWithAuth(ApiConstants.notifications);
      // print(response.runtimeType);
      // final data = json.decode(response);
      pollNotificationModel = [];
      // response = response['data'];
      response.map((item) {
        pollNotificationModel.add(Notifications.fromJson(item));
      }).toList();
      if (notificationModel != pollNotificationModel) {
        notificationModel = pollNotificationModel;
        apiResponseNotification = ApiResponse.success(false, notificationModel);
      }
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponseNotification =
          ApiResponse.error(false, "Could not Transaction");
    }
    notifyListeners();
  }

  void pollTables() async {
    try {
      var response = await httpRequest.getWithAuth(ApiConstants.getTables);
      // print(response.runtimeType);
      // final data = json.decode(response);
      pollTableModel = [];
      response = response['data'];
      response.map((item) {
        pollTableModel.add(TableModel.fromJson(item));
      }).toList();
      if (pollTableModel != tableModel) {
        tableModel = pollTableModel;
        apiResponse = ApiResponse.success(false, tableModel);
        notifyListeners();
      }
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Could not Transaction");
    }
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
}
