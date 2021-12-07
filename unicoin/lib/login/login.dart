import 'package:flutter/material.dart';
import 'package:unicoin/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 35, 42),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('Background.png'),
          fit: BoxFit.cover,
        )),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'logo.png',
              height: 350,
            ),
            const SizedBox(height: 20),
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color: const Color.fromARGB(255, 94, 213, 168),
              loginMethod: AuthService().googleLogin,
            ),
            const SizedBox(height: 20),
            LoginButton(
              icon: FontAwesomeIcons.userNinja,
              text: 'Continue as Guest',
              loginMethod: AuthService().anonLogin,
              color: const Color.fromARGB(255, 94, 213, 168),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: color,
          ),
          onPressed: () => loginMethod(),
          label: Text(text, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
