import "package:flutter/material.dart";
import 'package:unicoin/market/market.dart';
import 'package:unicoin/services/auth.dart';
import 'package:unicoin/login/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error", textDirection: TextDirection.ltr),
            );
          } else if (snapshot.hasData) {
            return MarketScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
