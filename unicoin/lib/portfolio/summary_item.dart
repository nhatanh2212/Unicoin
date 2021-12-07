import "package:flutter/material.dart";
import 'package:unicoin/market/coin.dart';

class SummaryItem extends StatelessWidget {
  final Map coin;
  final double amount;
  final int id;

  const SummaryItem(
      {Key? key, required this.coin, required this.id, required this.amount})
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
                child: Image.network(coin["image"], width: 25, height: 25),
              ),
              Expanded(
                flex: 35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${coin["name"]}',
                            style: const TextStyle(fontSize: 15)),
                        const SizedBox(
                          width: 8,
                        ),
                        Text('$amount', style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    Text(
                      '${coin["current_price"] * amount}',
                      style: TextStyle(
                          fontSize: 12,
                          color: (coin["price_change_percentage_24h"] < 0)
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: Text(
                  coin["price_change_percentage_24h"].toStringAsFixed(2) + "%",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: (coin["price_change_percentage_24h"] < 0)
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 30,
                child: Text(
                  '\$${coin["current_price"]}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 12,
                      color: (coin["price_change_percentage_24h"] < 0)
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }
}
