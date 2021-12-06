import "package:flutter/material.dart";

class MarketItem extends StatelessWidget {
  final Map coin;
  final int id;

  const MarketItem({Key? key, required this.coin, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text('$id'),
            ),
            Expanded(
              flex: 15,
              child: Image.network(coin["image"], width: 30, height: 30),
            ),
            Expanded(
              flex: 40,
              child: Text('${coin["name"]}'),
            ),
            Expanded(
              flex: 20,
              child: Text(
                coin["price_change_percentage_24h"].toStringAsFixed(2) + "%",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                    color: (coin["price_change_percentage_24h"] < 0)
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
