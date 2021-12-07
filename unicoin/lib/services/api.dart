// ignore_for_file: unnecessary_brace_in_string_interps

import "package:http/http.dart" as http;
import 'package:unicoin/constants.dart';
import 'dart:convert';

class Api {
  final String _url = "https://api.coingecko.com/api/v3";

  Future<List> fetchMarketData({List? coins}) async {
    String query = "";
    if (coins != null) {
      if (coins.isEmpty) return [];
      coins.asMap().forEach((index, coin) {
        query += coin!;
        if (index != coins.length - 1) query += ",";
      });
    } else {
      supportedCoins.asMap().forEach((index, coin) {
        query += coin["id"]!;
        if (index != supportedCoins.length - 1) query += ",";
      });
    }

    try {
      final response = await http
          .get(Uri.parse(_url + "/coins/markets?vs_currency=usd&ids=" + query));
      final data = jsonDecode(response.body) as List;
      return data;
    } catch (error) {
      return ["ERROR!"];
    }
  }

  Future<Map> getCoinHistory(String id, int days) async {
    String formattedDays = (days == -1) ? "max" : days.toString();
    String query =
        "/coins/${id}/market_chart?days=${formattedDays}&vs_currency=usd";
    if (days == -1) query += "&interval=daily";
    try {
      final response = await http.get(Uri.parse(_url + query));
      final data = jsonDecode(response.body) as Map;
      return data;
    } catch (error) {
      return {"error": "ERROR!"};
    }
  }

  Future<Map> getCoinAtDateTime(String id, DateTime date) async {
    String formattedDate = date.day.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.year.toString();

    String query = "/coins/" +
        id +
        // ignore: unnecessary_brace_in_string_interps
        '/history?date=${formattedDate}&sparkline=true&tickers=false&comnunity_data=false&developer_data=false&localization=false';

    try {
      final response = await http.get(Uri.parse(_url + query));
      final data = jsonDecode(response.body) as Map;

      return data;
    } catch (error) {
      return {"error": "ERROR!"};
    }
  }
}
