import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const SizedBox(
            height: 200,
            width: 200,
            child: Image(image: AssetImage("logo.png"))),
        SizedBox(height: 20),
        Button(
          icon: FontAwesomeIcons.facebook,
          text: "Like us on Facebook",
          press: () {},
        ),
        Button(
          icon: FontAwesomeIcons.twitter,
          text: "Like us on Twitter",
          press: () {},
        ),
        Button(
          icon: FontAwesomeIcons.instagram,
          text: "Like us on Instagram",
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
            primary: Color.fromARGB(255, 94, 213, 168),
            onPrimary: Colors.white,
            onSurface: Color.fromARGB(255, 24, 24, 24),
          ),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: Color.fromARGB(255, 44, 44, 44),
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
