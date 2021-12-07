import 'package:flutter/material.dart';
import 'package:unicoin/portfolio/transactions_item.dart';
import 'package:unicoin/services/api.dart';
import 'package:unicoin/services/firestore.dart';

import 'transactions_item.dart';
import '../shared/error.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: FirestoreService().getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var transactions = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color.fromARGB(255, 27, 35, 42),
                title: Row(
                  children: const [
                    Expanded(
                        child: Text('Transactions',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )))
                  ],
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Background_base.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: _TransactionsListWidget(transactions: transactions),
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

class _TransactionsListWidget extends StatefulWidget {
  final List transactions;

  const _TransactionsListWidget({Key? key, required this.transactions}) : super(key: key);

  @override
  _TransactionsListWidgetState createState() => _TransactionsListWidgetState();
}

class _TransactionsListWidgetState extends State<_TransactionsListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getTransactionsInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var transHistory = snapshot.data!;

          return ListView.builder(
              itemCount: transHistory.length,
              itemBuilder: (BuildContext context, index) {
                if (index == 0) {
                  return Column(children: [
                    const Title(),
                    TransactionsItem(coin: transHistory[index], id: index, amount: widget.transactions[index]["amount"].toDouble(), time: widget.transactions[index]["time"].toDate()),
                  ]);
                } else {
                  return TransactionsItem(coin: transHistory[index], id: index, amount: widget.transactions[index]["amount"].toDouble(), time: widget.transactions[index]["time"].toDate());
                }
              });
        } else {
          return const Text("No market data found in the api",
              textDirection: TextDirection.ltr);
        }
      }
    );
  }

  Future<List> getTransactionsInfo() async {
    List info = [];
    
    for (var element in widget.transactions) {
      var trans = await Api().getCoinAtDateTime(element["coinID"], DateTime.parse(element["time"].toDate().toString()));
      info.add(trans);
    }

    return info;
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
              "Amount",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Text(
              'Time',
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
