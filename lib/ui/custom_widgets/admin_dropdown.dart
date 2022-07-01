import 'dart:async';

import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/notification_model.dart';
import 'package:annapurna/providers/dashboard_provider.dart';
import 'package:annapurna/utils/save_data.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminDropDownStatefulWidget extends ConsumerStatefulWidget {
  const AdminDropDownStatefulWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminDropDownStatefulWidget> createState() =>
      _AdminDropdownStatefulWidgetState();
}

class _AdminDropdownStatefulWidgetState
    extends ConsumerState<AdminDropDownStatefulWidget> {
  List<String> items = [
    'Admin',
    'Settings',
    'Logout',
  ];
  List<Notifications> notificationModel = [];
  String? selectedValue;
  String role = "NA";
  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    Timer.periodic(const Duration(seconds: 1), (_) => _fetchNotification());
  }

  _fetchNotification() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp)
    ref.read(dashboardNotifierProvider).pollNotifications();
    // });
  }

  _checkLoggedIn() async {
    var role = await SaveData.getRole();
    if (role != "") {
      items[0] = role.toUpperCase();
      setState(() {
        this.role = role.toUpperCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final provider = ref.watch(dashboardNotifierProvider);
      if (provider.notificationModel.length > notificationModel.length) {
        notificationModel = provider.notificationModel;
        print(notificationModel[notificationModel.length - 1]);
      }
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.white,
          iconDisabledColor: Colors.grey,
          buttonHeight: 40,
          buttonWidth: 160,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black26,
            ),
            color: colorTable,
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: colorTable,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      );
    });
  }
}
