import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
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

  Future<Map> getSummary() async {
    final user = AuthService().user!;
    try {
      var ref = _db.collection('users').doc(user.uid);
      var snapshot = await ref.get();

      if (snapshot.exists) {
        var data = snapshot.data()!;

        if (!data.containsKey("portfolio")) {
          return {};
        }

        if (!data["portfolio"].containsKey("summary")) {
          return {};
        }

        return data["portfolio"]["summary"];
      } else {
        return {};
      }
    } catch (error) {
      return {};
    }
  }

  void addTransaction(String coinID, int amount, Timestamp time) async {
    final user = AuthService().user!;

    try {
      var ref = _db.collection('users').doc(user.uid);
      var data = {
        "portfolio.summary.$coinID": FieldValue.increment(amount)
      };
      await ref.update(data);

      Map trans = {
        "coinID": coinID,
        "amount": amount,
        "time": time
      };

      data = {
        "portfolio.transactions": FieldValue.arrayUnion([trans])
      };
      await ref.update(data);
    } catch (error) {
      print(error);
    }
  }

  Future<List> getTransactions() async {
    final user = AuthService().user!;
    try {
      var ref = _db.collection('users').doc(user.uid);
      var snapshot = await ref.get();

      if (snapshot.exists) {
        var data = snapshot.data()!;

        if (!data.containsKey("portfolio")) {
          return [];
        }

        if (!data["portfolio"].containsKey("transactions")) {
          return [];
        }

        return data["portfolio"]["transactions"];
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Stream<Map?> streamFavourite() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('users').doc(user.uid);
        return ref.snapshots().map((doc) {
          if (doc.exists) {
            return doc.data();
          } else {
            return {"favourites": []};
          }
        });
      } else {
        return Stream.fromIterable([
          {"favourites": []}
        ]);
      }
    });
  }
}
