import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class TransactionsForm extends StatefulWidget {
  final coin;

  const TransactionsForm({Key? key, required this.coin}) : super(key: key);

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  int? _amount;
  late DateTime date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            initialDateTime: DateTime(2002, 1, 1),
            onDateTimeChanged: (DateTime newDateTime) {
              date = newDateTime;
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

                    Map data = {
                      "coinId": widget.coin["id"],
                      "time": date, //Timestamp.fromDate(date),
                      "amount": _amount,
                    };
                    print(data);
                    //Send to API
                  },
                )
              ]),
            ),
          ),
        ));
  }
}
