import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicoin/services/api.dart';

import '../shared/error.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late List _market;
  late Future<void> _initMarketData;

  @override
  void initState() {
    super.initState();
    _initMarketData = _initMarket();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initMarketData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (_market.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor:
                    Theme.of(context).appBarTheme.backgroundColor,
                title: const Text("Market"),
              ),
              body: ListView.builder(
                itemCount: _market.length,
                itemBuilder: (BuildContext context, index) => ListTile(
                  title: Text(_market[index]["name"]),
                ),
              )
            );
            /*
            return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  title: const Text("Market"),
                ),
                body: RefreshIndicator(
                  onRefresh: _refreshMarket,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(),
                          Container(
                            child: ListView.builder(
                              itemCount: _market.length,
                              itemBuilder: (BuildContext context, index) =>
                                  ListTile(
                                title: Text(_market[index]["name"]),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ));
            */
          } else {
            return const Text("No market data found in the api",
                textDirection: TextDirection.ltr);
          }
        });
  }

  Future<void> _initMarket() async {
    final data = await Api().fetchMarketData();
    _market = data;
  }

  Future<void> _refreshMarket() async {
    final data = await Api().fetchMarketData();
    setState(() {
      _market = data;
    });
  }
}
