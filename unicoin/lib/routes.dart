import 'package:unicoin/home/home.dart';
import 'package:unicoin/login/login.dart';
import 'package:unicoin/market/market.dart';
import 'package:unicoin/portfolio/portfolio.dart';
import 'package:unicoin/profile/profile.dart';

var appRoutes = {
  "/": (context) => const HomeScreen(),
  "/login": (context) => const LoginScreen(),
  "/market": (context) => const MarketScreen(),
  "/portfolio": (context) => const PortfolioScreen(),
  "/profile": (context) => const ProfileScreen(),
};
