import 'package:unicoin/home/home.dart';
import 'package:unicoin/login/login.dart';
import 'package:unicoin/market/market.dart';

var appRoutes = {
  "/": (context) => const HomeScreen(),
  "/login": (context) => const LoginScreen(),
  "/market": (context) => const MarketScreen(),
};
