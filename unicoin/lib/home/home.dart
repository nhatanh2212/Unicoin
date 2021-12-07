import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicoin/favourite/favourite.dart';
import 'package:unicoin/market/market.dart';
import 'package:unicoin/portfolio/portfolio.dart';
import 'package:unicoin/profile/profile.dart';
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
            return const MainScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MarketScreen(),
    PortfolioScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 20,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 27, 35, 42),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.chartLine,
            ),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.briefcase,
            ),
            label: 'Porfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.heart,
            ),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.userAlt,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
