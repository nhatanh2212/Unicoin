import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:unicoin/portfolio/portfolio.dart';
import 'package:unicoin/services/api.dart';

import '../services/firestore.dart';

class TransactionsForm extends StatefulWidget {
  final coin;

  const TransactionsForm({Key? key, required this.coin}) : super(key: key);

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  int? _amount;
  DateTime date = DateTime.now();
  late num price = widget.coin["current_price"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void getNewCoinStat(DateTime date) async {
    if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      setState(() {
        price = widget.coin["current_price"];
      });
      return;
    }
    try {
      final data = await Api().getCoinAtDateTime(widget.coin["id"], date);
      setState(() {
        price = data["market_data"]["current_price"]["usd"];
      });
    } catch (error) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    price = widget.coin["current_price"];
  }

  Widget _buildAmount() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Amount'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value == null) {
          return "You must specify an amount.";
        }

        int? calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Amount must be greater than 0';
        }

        return null;
      },
      onSaved: (String? value) {
        _amount = int.tryParse(value!);
      },
    );
  }

  Widget _buildDate() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
                TextStyle(inherit: false, color: Colors.white, fontSize: 15),
          ),
        ),
        child: CupertinoDatePicker(
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              getNewCoinStat(newDateTime);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 27, 35, 42),
            title: const Text("New transaction")),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('Background_base.jpg'),
            fit: BoxFit.cover,
          )),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: ListView(children: <Widget>[
                Row(
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
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.coin["name"]}',
                          style: const TextStyle(fontSize: 35),
                        ),
                      ),
                    )
                  ],
                ),
                _buildAmount(),
                const SizedBox(height: 20),
                const Text("Transaction date: "),
                _buildDate(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 2,
                      child:
                          Text('Coin price:', style: TextStyle(fontSize: 15)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text('\$${price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text(
                    'Add to portfolio',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState!.save();

                    FirestoreService().addTransaction(
                        widget.coin["id"], _amount!, Timestamp.fromDate(date));

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                )
              ]),
            ),
          ),
        ));
  }
}
