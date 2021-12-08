import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:unicoin/services/firestore.dart';

class TransactionsForm extends StatefulWidget {
  final coin;

  const TransactionsForm({Key? key, required this.coin}) : super(key: key);

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  int? _amount;
  DateTime date = DateTime.now();

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
    return Container(
      height: 400,
      child: CupertinoDatePicker(
          dateOrder: DatePickerDateOrder.dmy,
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime newDateTime) {
            date = newDateTime;
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 27, 35, 42),
            title: const Text("New transaction")),
        body: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('Background_base.jpg'),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: ListView(children: <Widget>[
                _buildAmount(),
                _buildDate(),
                ElevatedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState!.save();

                    FirestoreService().addTransaction(
                        widget.coin["id"], _amount!, Timestamp.fromDate(date));
                  },
                )
              ]),
            ),
          ),
        ));
  }
}
