import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/src/transformers/switch_map.dart';
import 'package:unicoin/services/api.dart';
import 'package:unicoin/services/auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List> getFavourites() async {
    final user = AuthService().user!;
    try {
      var ref = _db.collection('users').doc(user.uid);
      var snapshot = await ref.get();
      if (snapshot.exists) {
        var data = snapshot.data()!;
        if (data["favourites"].length == 0) {
          return [];
        }

        var favouriteCoinsData =
            await Api().fetchMarketData(coins: data["favourites"]);

        return favouriteCoinsData;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  void addFavourite(String id) async {
    try {
      var user = AuthService().user!;
      var ref = _db.collection('users').doc(user.uid);
      var data = {
        'favourites': FieldValue.arrayUnion([id])
      };
      await ref.set(data, SetOptions(merge: true));
    } catch (error) {}
  }

  void removeFavourite(String id) async {
    try {
      var user = AuthService().user!;
      var ref = _db.collection('users').doc(user.uid);
      var data = {
        'favourites': FieldValue.arrayRemove([id])
      };
      await ref.set(data, SetOptions(merge: true));
    } catch (error) {}
  }

  Stream<Map?> streamFavourite() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('users').doc(user.uid);
        return ref.snapshots().map((doc) => doc.data());
      } else {
        return Stream.fromIterable([
          {"favourites": []}
        ]);
      }
    });
  }

  Future<Map> getSummary() async {
    final user = AuthService().user!;

    try {
      var ref = _db.collection('users').doc(user.uid).collection("portfolios");
      var snapshot = await ref.orderBy("creationTime").limit(1).get();

      if (snapshot.size > 0) {
        // var favouriteCoinsData = await Api().fetchMarketData(coins: data["favourites"]);
        var data = snapshot.docs[0];

        return {
          "name": data["name"],
          "summary": data["summary"]
        };
      } else {
        return {};
      }
    } catch(error) {
      print(error);
      return {};
    }
  }
}
