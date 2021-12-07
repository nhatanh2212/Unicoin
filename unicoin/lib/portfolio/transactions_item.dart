import "package:flutter/material.dart";
import 'package:unicoin/market/coin.dart';

class TransactionsItem extends StatelessWidget {
  final Map coin;
  final double amount;
  final DateTime time;
  final int id;

  const TransactionsItem(
      {Key? key, required this.coin, required this.id, required this.amount, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => CoinScreen(coin: coin)));
      },
      child: Container(
          padding:
          const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Text('${id + 1}'),
              ),
              Expanded(
                flex: 10,
                child: Image.network(coin["image"]["small"], width: 25, height: 25),
              ),
              Expanded(
                flex: 35,
                child: Text('${coin["name"]}', style: TextStyle(fontSize: 15)),
              ),
              Expanded(
                flex: 20,
                child: Text(
                    '$amount',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 30,
                child: Text(
                  time.day.toString() + "/" + time.month.toString() + "/" + time.year.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }
}
