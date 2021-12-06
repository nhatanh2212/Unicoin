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

  Future<Map> getCoinHistory(String id, DateTime date) async {
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

  Future<List> getCoinHistoryIn7Days(String id, DateTime date) async {
    List data = [];
    try {
      for (int i = 7; i >= 1; i--) {
        DateTime cur = date.subtract(Duration(days: i));
        var curData = await getCoinHistory(id, cur);
        data.add(curData);
      }
      return data;
    } catch (error) {
      return ["ERROR!"];
    }
  }
}
