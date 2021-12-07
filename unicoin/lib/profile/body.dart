import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/auth.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
          image: AssetImage('Background.jpg'),
          fit: BoxFit.cover,
        ))),
        const SizedBox(height: 20),
        const SizedBox(
            height: 200,
            width: 200,
            child: Image(image: AssetImage("logo.png"))),
        const SizedBox(height: 20),
        Button(
          icon: FontAwesomeIcons.signInAlt,
          text: "Log out",
          press: () async {
            await AuthService().signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        Button(
          icon: FontAwesomeIcons.userFriends,
          text: "Join community",
          press: () => Navigator.pushNamed(context, '/community'),
        ),
        Button(
          icon: FontAwesomeIcons.questionCircle,
          text: "Help and Support",
          press: () => Navigator.pushNamed(context, '/support'),
        ),
        Button(
          icon: FontAwesomeIcons.doorOpen,
          text: "About us",
          press: () => Navigator.pushNamed(context, '/about'),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;

  const Button({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            primary: const Color.fromARGB(255, 94, 213, 168),
            onPrimary: Colors.white,
            onSurface: const Color.fromARGB(255, 24, 24, 24),
          ),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color.fromARGB(255, 44, 44, 44),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(
                  color: Color.fromARGB(255, 70, 70, 70),
                  fontSize: 20,
                ),
              )),
              const Icon(
                FontAwesomeIcons.arrowCircleRight,
                color: Color.fromARGB(255, 48, 48, 48),
              ),
            ],
          )),
    );
  }
}
