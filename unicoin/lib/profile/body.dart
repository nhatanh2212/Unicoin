import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/auth.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('Background.jpg'),
          fit: BoxFit.cover,
        )),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const SizedBox(
                height: 200,
                width: 200,
                child: Image(image: AssetImage("logo.png"))),
            const SizedBox(height: 20),
            Button(
              color: const Color.fromARGB(255, 221, 75, 75),
              icon: FontAwesomeIcons.signInAlt,
              text: "Log out",
              press: () async {
                await AuthService().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            Button(
              color: const Color.fromARGB(255, 94, 213, 168),
              icon: FontAwesomeIcons.userFriends,
              text: "Join community",
              press: () => Navigator.pushNamed(context, '/community'),
            ),
            Button(
              color: const Color.fromARGB(255, 94, 213, 168),
              icon: FontAwesomeIcons.questionCircle,
              text: "Help and Support",
              press: () => Navigator.pushNamed(context, '/support'),
            ),
          ],
        ));
  }
}

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;
  final Color color;

  const Button({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: color,
            textStyle: const TextStyle(fontSize: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )),
              const Icon(
                FontAwesomeIcons.arrowCircleRight,
              ),
            ],
          )),
    );
  }
}
