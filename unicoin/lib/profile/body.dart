import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const SizedBox(
            height: 115,
            width: 115,
            child: CircleAvatar(
              backgroundImage: AssetImage("logo.png"),
            )),
        const SizedBox(height: 20),
        Button(
          icon: FontAwesomeIcons.signInAlt,
          text: "Create Account/ sign in",
          press: () {},
        ),
        Button(
          icon: FontAwesomeIcons.userFriends,
          text: "Join community",
          press: () {},
        ),
        Button(
          icon: FontAwesomeIcons.questionCircle,
          text: "Help and Support",
          press: () {},
        ),
        Button(
          icon: FontAwesomeIcons.google,
          text: "Create Account/ sign in",
          press: () {},
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
            primary: Colors.teal,
            onPrimary: Colors.white,
            onSurface: Colors.grey,
          ),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: Color.fromARGB(255, 215, 233, 226),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(
                  color: Color.fromARGB(255, 215, 233, 226),
                  fontSize: 20,
                ),
              )),
              const Icon(
                FontAwesomeIcons.arrowCircleRight,
                color: Color.fromARGB(255, 215, 233, 226),
              ),
            ],
          )),
    );
  }
}
