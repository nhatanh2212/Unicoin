import "package:flutter/material.dart";
import 'package:unicoin/services/firestore.dart';
import 'package:unicoin/services/api.dart';

import 'transactions.dart';
import 'summary_item.dart';
import '../shared/bottom_nav.dart';
import '../shared/error.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: FirestoreService().getSummary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            if (data.isEmpty) {
              return Scaffold(
                  appBar: AppBar(title: const Text("Portfolios")),
                  body: const Center(
                      child: Text(
                    "You do not have any portfolios yet!",
                    textDirection: TextDirection.ltr,
                  )));
            }

            return Scaffold(
              appBar: AppBar(title: const Text("Portfolios")),
              body: RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: Column(
                  children: [
                    _SummaryListWidget(summary: data["summary"]),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TransactionsScreen()));
                      },
                      child: const Text("Transactions"),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text("No market data found in the api",
                textDirection: TextDirection.ltr);
          }
        });
  }
}

class _SummaryListWidget extends StatefulWidget {
  final Map summary;

  const _SummaryListWidget({Key? key, required this.summary}) : super(key: key);

  @override
  _SummaryListWidgetState createState() => _SummaryListWidgetState();
}

class _SummaryListWidgetState extends State<_SummaryListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: Api().fetchMarketData(coins: widget.summary.keys.toList()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var market = snapshot.data!;

            return ListView.builder(
                itemCount: market.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  if (index == 0) {
                    return Column(children: [
                      const Title(),
                      SummaryItem(
                          coin: market[index],
                          id: index,
                          amount:
                              widget.summary[market[index]["id"]].toDouble()),
                    ]);
                  } else {
                    return SummaryItem(
                        coin: market[index],
                        id: index,
                        amount: widget.summary[market[index]["id"]].toDouble());
                  }
                });
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
