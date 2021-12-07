import "package:flutter/material.dart";
import 'package:unicoin/market/lineChart.dart';

class CoinScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final Map coin;

  const CoinScreen({Key? key, required this.coin}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  late int days;

  @override
  void initState() {
    super.initState();
    days = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.coin["name"])),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: LineChartWidget(id: widget.coin["id"], days: days),
          ),
          Options(
              chosenValue: days,
              changeStateFunction: (d) {
                setState(() {
                  days = d;
                });
              })
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Options extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final chosenValue;
  final Function changeStateFunction;
  var choices = [
    {
      "displayText": "24H",
      "value": 1,
    },
    {
      "displayText": "1W",
      "value": 7,
    },
    {
      "displayText": "1M",
      "value": 30,
    },
    {
      "displayText": "3M",
      "value": 90,
    },
    {
      "displayText": "6M",
      "value": 180,
    },
    {
      "displayText": "1Y",
      "value": 365,
    },
    {
      "displayText": "ALL",
      "value": -1,
    }
  ];

  Options(
      {Key? key, required this.chosenValue, required this.changeStateFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> choicesWidget = [];
    for (var choice in choices) {
      choicesWidget.add(Expanded(
          flex: 15,
          child: TextButton(
            onPressed: () {
              changeStateFunction(choice["value"]);
            },
            child: Text(
              "${choice["displayText"]}",
              style: TextStyle(
                  fontSize: 15,
                  color: (choice["value"] == chosenValue)
                      ? Colors.white
                      : Colors.grey),
            ),
          )));
    }

    return Row(
      children: choicesWidget,
    );
  }
}
