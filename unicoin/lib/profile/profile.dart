import "package:flutter/material.dart";
import 'package:unicoin/shared/bottom_nav.dart';
import 'package:unicoin/profile/body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 27, 35, 42),
        title: Row(
          children: const [
            Expanded(
                child: Text('Profile',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 94, 213, 168),
                    )))
          ],
        ),
      ),
      body: const Body(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
