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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage("logo.png"))),
                SizedBox(
                    child: Column(
                  children: const [
                    Text("About Unicoin",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 1.2)),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'This mini-app is a cryptocurrency portfolio tracker that uses Coingecko'
                        's public API. You may use this app to enter the crypto market and manage your portfolio. Your profits and losses, asset distribution, and equity history chart may all be viewed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            )));
  }
}
