import 'package:annapurna/constants/colors.dart';
import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
  final int status;
  const TableItem({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = colorVacant;
    String textStatus = 'Vacant';
    if (status == 0) {
      color = colorOccupied;
      textStatus = 'Occupied';
    } else if (status == 1) {
      color = colorVacant;
      textStatus = 'Vacant';
    } else if (status == 2) {
      color = colorReserved;
      textStatus = 'Reserved';
    }
    return SizedBox(
      height: 150,
      width: 200,
      child: Stack(
        // clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 26,
            child: Container(
              width: 60.0,
              height: 150.0,
              decoration: const BoxDecoration(
                  color: colorTable,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            ),
          ),
          Positioned(
            left: 116,
            child: Container(
              width: 60.0,
              height: 150.0,
              decoration: const BoxDecoration(
                  color: colorTable,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            ),
          ),
          Positioned(
            top: 25,
            child: Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                  color: colorTable,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: colorBackground, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(16.0))),
            ),
          ),
          const Positioned(
            top: 40,
            left: 20,
            child: Text(
              'T1',
              style: TextStyle(color: colorGreyText),
            ),
          ),
          Positioned(
            top: 96,
            left: 20,
            child: Text(
              textStatus,
              style: TextStyle(color: color),
            ),
          ),
          Positioned(
            left: 180,
            top: 26,
            child: Container(
              width: 20.0,
              height: 96.0,
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: color, width: 3),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0))),
            ),
          ),
        ],
      ),
    );
  }
}
