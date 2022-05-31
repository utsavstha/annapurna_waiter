import 'package:annapurna/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FloorDropDownStatefulWidget extends StatefulWidget {
  const FloorDropDownStatefulWidget({Key? key}) : super(key: key);

  @override
  State<FloorDropDownStatefulWidget> createState() =>
      _FloorDropdownStatefulWidgetState();
}

class _FloorDropdownStatefulWidgetState
    extends State<FloorDropDownStatefulWidget> {
  final List<String> items = [
    'Floor One',
    'Floor Two',
    'Floor Three',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Expanded(
              child: Text(
                'Select Floor',
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
  }
}
