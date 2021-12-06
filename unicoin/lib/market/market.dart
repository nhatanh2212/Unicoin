import "package:flutter/material.dart";
import 'package:unicoin/market/market_item.dart';
import 'package:unicoin/services/api.dart';
import 'package:unicoin/shared/bottom_nav.dart';

import '../shared/error.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: Api().fetchMarketData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var market = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                title: const Text("Market"),
              ),
              body: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, index) =>
                          MarketItem(coin: market[index], id: index))),
              bottomNavigationBar: const BottomNavBar(),
            );
          } else {
            return const Text("No market data found in the api",
                textDirection: TextDirection.ltr);
          }
        });
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 5,
          child: Text('#'),
        ),
        Expanded(
          flex: 45,
          child: Text('Name'),
        ),
        Expanded(
          flex: 20,
          child: Text(
            "24h",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 30,
          child: Text(
            'Price',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
