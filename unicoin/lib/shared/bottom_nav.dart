import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.chartLine,
            size: 20,
          ),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.briefcase,
            size: 20,
          ),
          label: 'Porfolio',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.heart,
            size: 20,
          ),
          label: 'Favourite',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.userAlt,
            size: 20,
          ),
          label: 'Profile',
        ),
      ],
      fixedColor: Color.fromARGB(255, 94, 213, 168),
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.pushNamed(context, '/portfolio');
            break;
          case 2:
            Navigator.pushNamed(context, '/favourite');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
