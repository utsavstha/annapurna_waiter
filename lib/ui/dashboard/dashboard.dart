import 'dart:async';

import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/model/table_model.dart';
import 'package:annapurna/providers/dashboard_provider.dart';
import 'package:annapurna/routes/app_pages.dart';
import 'package:annapurna/ui/custom_widgets/admin_dropdown.dart';
import 'package:annapurna/ui/custom_widgets/dropdown_widget.dart';
import 'package:annapurna/ui/custom_widgets/table_item.dart';
import 'package:annapurna/utils/no_data.dart';
import 'package:annapurna/utils/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(dashboardNotifierProvider).getTables();
    });
    Timer.periodic(const Duration(seconds: 10), (_) => _fetchData());
  }

  _fetchData() {
    // WidgetsBinding.nstance!.addPostFrameCallback((timeStamp) {
    ref.read(dashboardNotifierProvider).pollTables();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: colorBackgroundDark,
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // FloorDropDownStatefulWidget(),
                    AdminDropDownStatefulWidget()
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  final provider = ref.watch(dashboardNotifierProvider);

                  // if (provider.apiResponse.isLoading) {
                  //   return const ProgressDialog();
                  // }
                  if (provider.apiResponse.model == null ||
                      (provider.apiResponse.model as List<TableModel>) ==
                          null) {
                    return const NoData();
                  } else {
                    final data =
                        (provider.apiResponse.model as List<TableModel>);

                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.takeOrder,
                                  arguments: {
                                    "tableId": data[index].id,
                                    "status": data[index].status
                                  });
                            },
                            child: TableItem(
                              data: data[index],
                            ),
                          );
                        });
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
