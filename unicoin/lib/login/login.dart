import 'package:flutter/material.dart';
import 'package:unicoin/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:particles_flutter/particles_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 35, 42),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('Background.jpg'),
          fit: BoxFit.cover,
        )),
        padding: const EdgeInsets.all(30),
        child: Stack(children: [
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 500,
            numberOfParticles: 50,
            speedOfParticles: 1,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: Colors.white.withAlpha(150),
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 4,
            isRandSize: true,
            isRandomColor: false,
            randColorList: [
              Colors.white.withAlpha(150),
              Colors.white.withAlpha(10),
              Colors.white.withAlpha(70),
              Colors.white.withAlpha(200)
            ],
            awayAnimationCurve: Curves.easeInOutBack,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 100,
            connectDots: true,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'logo.png',
                height: 350,
              ),
              const Text("Welcome to Unicoin!",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.2)),
              const SizedBox(height: 20),
              LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: AuthService().anonLogin,
                color: const Color.fromARGB(255, 94, 213, 168),
              ),
              const SizedBox(height: 5),
              LoginButton(
                text: 'Sign in with Google',
                icon: FontAwesomeIcons.google,
                color: const Color.fromARGB(255, 221, 75, 75),
                loginMethod: AuthService().googleLogin,
              ),
            ],
          ),
        ]),
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
      width: size.width * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton.icon(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: color,
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () => loginMethod(),
          label: Text(text, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
