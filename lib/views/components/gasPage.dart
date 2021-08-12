import 'package:flutter/material.dart';
import 'package:fastfill/models/gasmodel.dart';
import 'package:fastfill/views/components/gasitemcard.dart';

class GasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (context, int key) {
          return GasItemCard(index: key);
        },
      ),
    );
  }
}
