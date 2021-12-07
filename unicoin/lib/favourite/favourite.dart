import "package:flutter/material.dart";
import 'package:unicoin/services/firestore.dart';

import '../market/market_item.dart';
import '../shared/bottom_nav.dart';
import '../shared/error.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: FirestoreService().getFavourites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;

            if (data.isEmpty) {
              return Scaffold(
                  appBar: AppBar(title: const Text("Favourites")),
                  body: const Center(
                      child: Text(
                    "You do not have any favourite coins yet!",
                    textDirection: TextDirection.ltr,
                  )));
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Favourites"),
                backgroundColor: const Color.fromARGB(255, 27, 35, 42),
              ),
              body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('Background_base.jpg'),
                  fit: BoxFit.cover,
                )),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, index) {
                        return MarketItem(coin: data[index], id: index);
                      }),
                ),
              ),
              bottomNavigationBar: BottomNavBar(),
            );
          } else {
            return const Text("No market data found in the api",
                textDirection: TextDirection.ltr);
          }
        });
  }
}
