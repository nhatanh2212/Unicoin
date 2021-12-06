import "package:flutter/material.dart";

class MarketScreen extends StatefulWidget {
  MarketScreen({Key? key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text("Market screen", textDirection: TextDirection.ltr);
  }
}
