import "package:flutter/material.dart";
import 'package:unicoin/market/lineChart.dart';
import 'package:unicoin/portfolio/transactions_form.dart';
import 'package:unicoin/services/firestore.dart';
import 'package:provider/provider.dart';

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
    var user = Provider.of<Map>(context);
    bool isAFavourite = false;
    for (var favourite in user["favourites"]) {
      if (favourite == widget.coin["id"]) {
        isAFavourite = true;
        break;
      }
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 27, 35, 42),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.coin["name"]),
                const Text("USD"),
              ],
            )),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('Background_base.jpg'),
            fit: BoxFit.cover,
          )),
          child: ListView(
            children: <Widget>[
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
                  }),
              Row(
                children: [
                  Expanded(
                    flex: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          if (isAFavourite) {
                            FirestoreService()
                                .removeFavourite(widget.coin["id"]);
                          } else {
                            FirestoreService().addFavourite(widget.coin["id"]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: isAFavourite
                              ? Colors.grey.shade600
                              : Colors.red.shade500,
                        ),
                        child: Text(isAFavourite
                            ? "Remove from favourite"
                            : "Add to favourite")),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TransactionsForm(coin: widget.coin)));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: const Text("Add transaction"),
                    ),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Image.network(widget.coin["image"],
                            width: 50, height: 50),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 80,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${widget.coin["name"]}',
                            style: const TextStyle(fontSize: 35),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('CURRENT PRICE:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '\$${widget.coin["current_price"]}',
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  (widget.coin["price_change_percentage_24h"] <
                                          0)
                                      ? Colors.red
                                      : Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child:
                            Text('MARKET CAP:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$${widget.coin["market_cap"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('MARKET CAP RANK:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["market_cap_rank"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('TOTAL VOLUME:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$${widget.coin["total_volume"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child:
                            Text('HIGH 24H:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$${widget.coin["high_24h"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('LOW 24H:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$${widget.coin["low_24h"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('PRICE CHANGE 24H:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["price_change_24h"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('MARKET CAP CHANGE 24H:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["market_cap_change_24h"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('CIRCULATING SUPPLY:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["circulating_supply"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('TOTAL SUPPLY:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["total_supply"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child:
                            Text('MAX SUPPLY:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["max_supply"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('ATH:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$${widget.coin["ath"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('ATH CHANGE PERCENTAGE:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["ath_change_percentage"]}%',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child:
                            Text('ATH DATE:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            '${widget.coin["ath_date"].substring(0, 10)}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('ATL:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('\$${widget.coin["atl"]}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text('ATL CHANGE PERCENTAGE:',
                            style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${widget.coin["atl_change_percentage"]}%',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child:
                            Text('ATL DATE:', style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            '${widget.coin["atl_date"].substring(0, 10)}',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ],
                  ))
            ],
          ),
        ));
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
