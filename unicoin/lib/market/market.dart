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
            num marketCap = 0;
            for (var coin in market) {
              marketCap += coin["market_cap"];
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 27, 35, 42),
                toolbarHeight: 80,
                title: Row(
                  children: [
                    Expanded(
                        flex: 80,
                        child: Text('Market cap\n\$$marketCap',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15))),
                    const Expanded(flex: 20, child: Text('USD')),
                  ],
                ),
                automaticallyImplyLeading: false,
              ),
              body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('Background_base.jpg'),
                  fit: BoxFit.cover,
                )),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                      itemCount: market.length,
                      itemBuilder: (BuildContext context, index) {
                        if (index == 0) {
                          return Column(children: [
                            const Title(),
                            MarketItem(coin: market[index], id: index)
                          ]);
                        } else {
                          return MarketItem(coin: market[index], id: index);
                        }
                      }),
                ),
              ),
              bottomNavigationBar: BottomNavBar(),
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
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        children: const [
          Expanded(
            flex: 5,
            child: Text(
              '#',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 45,
            child: Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text(
                'Name',
                style: TextStyle(
                  color: Color.fromARGB(255, 184, 181, 181),
                ),
              ),
            ),
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
      ),
    );
  }
}
