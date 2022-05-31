import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/ui/custom_widgets/admin_dropdown.dart';
import 'package:annapurna/ui/custom_widgets/dropdown_widget.dart';
import 'package:annapurna/ui/custom_widgets/table_item.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloorDropDownStatefulWidget(),
                    AdminDropDownStatefulWidget()
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      if (index % 2 == 0) {
                        return const TableItem(
                          status: 0,
                        );
                      } else {
                        return const TableItem(
                          status: 1,
                        );
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
