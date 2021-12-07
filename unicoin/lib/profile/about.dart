import "package:flutter/material.dart";

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 27, 35, 42),
          title: Row(
            children: const [
              Expanded(
                  child: Text('About us',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )))
            ],
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('Background.jpg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: const [
                SizedBox(height: 20),
                SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage("logo.png"))),
                SizedBox(height: 5),
                SizedBox(height: 20),
                Box(
                  text:
                      "This mini-app is a cryptocurrency portfolio tracker that uses Coingecko's public API. You may use this page to enter the crypto market and manage your holdings. Your crypto management team is well-versed in the most recent crypto news. Sync your portfolios manually or automatically by connecting your exchanges and wallets. Your profits and losses, asset distribution, and equity history chart may all be viewed.",
                ),
              ],
            )));
  }
}

class Box extends StatelessWidget {
  final String text;

  const Box({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Expanded(
          child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
        ),
      )),
    );
  }
}
