import "package:flutter/material.dart";
import 'package:unicoin/market/lineChart.dart';

class CoinScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final Map coin;

  const CoinScreen({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(coin["name"])),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: LineChartWidget(id: coin["id"]),
          ),
        ],
      ),
    );
  }
}
