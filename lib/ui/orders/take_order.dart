import 'package:annapurna/constants/colors.dart';
import 'package:flutter/material.dart';

class TakeOrder extends StatelessWidget {
  TakeOrder({Key? key}) : super(key: key);
  final items = ['Appetizers', 'Main Course', 'Desserts', 'Beverages'];
  final icons = [
    Icons.restaurant_menu,
    Icons.fastfood,
    Icons.icecream,
    Icons.coffee
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: LeftList(icons: icons, items: items)),
              Expanded(child: RightList()),
            ],
          ),
        ),
      ),
    );
  }
}

class RightList extends StatelessWidget {
  const RightList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text('Baked Potatoes'), Text('NPR. 400.00')],
      ),
    );
  }
}

class LeftList extends StatelessWidget {
  const LeftList({
    Key? key,
    required this.icons,
    required this.items,
  }) : super(key: key);

  final List<IconData> icons;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(Card(
          child: SizedBox(
        width: 200,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(
                  icons[i],
                  color: Colors.grey,
                  size: 36.0,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(items[i])
              ],
            )),
      )));
    }
    return Column(
      children: widgets,
    );
  }
}
