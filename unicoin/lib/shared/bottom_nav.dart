import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  final Map routes = {
    "/": 0,
    "/market": 0,
    "/portfolio": 1,
    "/favourite": 2,
    "/profile": 3
  };

  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: ModalRoute.of(context)?.settings.name != null
          ? routes[ModalRoute.of(context)?.settings.name]
          : 0,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: (int idx) {
        switch (idx) {
          case 0:
            if (ModalRoute.of(context)?.settings.name == "/market") break;
            Navigator.pushNamed(context, '/market');
            break;
          case 1:
            if (ModalRoute.of(context)?.settings.name == "/portfolio") break;
            Navigator.pushNamed(context, '/portfolio');
            break;
          case 2:
            if (ModalRoute.of(context)?.settings.name == "/favourite") break;
            Navigator.pushNamed(context, '/favourite');
            break;
          case 3:
            if (ModalRoute.of(context)?.settings.name == "/profile") break;
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
