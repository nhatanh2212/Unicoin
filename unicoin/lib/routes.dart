import 'package:unicoin/favourite/favourite.dart';
import 'package:unicoin/home/home.dart';
import 'package:unicoin/login/login.dart';
import 'package:unicoin/market/market.dart';
import 'package:unicoin/portfolio/portfolio.dart';
import 'package:unicoin/profile/profile.dart';
import 'package:unicoin/profile/community.dart';
import 'package:unicoin/profile/support.dart';

var appRoutes = {
  "/": (context) => const HomeScreen(),
  "/login": (context) => const LoginScreen(),
  "/market": (context) => const MarketScreen(),
  "/portfolio": (context) => const PortfolioScreen(),
  "/profile": (context) => const ProfileScreen(),
  "/favourite": (context) => const FavouriteScreen(),
  "/community": (context) => const CommunityScreen(),
  "/support": (context) => const SupportScreen(),
};
