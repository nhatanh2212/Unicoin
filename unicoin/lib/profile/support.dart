import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 20),
        SizedBox(
            height: 200,
            width: 200,
            child: Image(image: AssetImage("logo.png"))),
        SizedBox(height: 20),
        Button(
          mainText: "Help center",
          subText:
              "You can check our Help Center for more common Question and tutorials.",
        ),
        Button(
          mainText: "Contact Us",
          subText: "If you have any questions, feel free to contact us.",
        ),
        Button(
          mainText: "Feature Requests",
          subText: "If you have any requests, feel free to message us.",
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String mainText, subText;

  const Button({
    Key? key,
    required this.mainText,
    required this.subText,
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
          onPressed: () {},
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                mainText,
                style: const TextStyle(
                  color: Color.fromARGB(255, 70, 70, 70),
                  fontSize: 20,
                ),
              )),
              Expanded(
                  child: Text(
                subText,
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
