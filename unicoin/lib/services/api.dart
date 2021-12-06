import "package:http/http.dart" as http;
import 'package:unicoin/constants.dart';
import 'dart:convert';

class Api {
  final String _url = "https://api.coingecko.com/api/v3";

  Future<List> fetchMarketData() async {
    String query = "";
    supportedCoins.asMap().forEach((index, coin) {
      query += coin["id"]!;
      if (index != supportedCoins.length - 1) query += ",";
    });

    try {
      final response = await http
          .get(Uri.parse(_url + "/coins/markets?vs_currency=usd&ids=" + query));
      final data = jsonDecode(response.body) as List;
      return data;
    } catch (error) {
      return ["ERROR!"];
    }
  }
}
