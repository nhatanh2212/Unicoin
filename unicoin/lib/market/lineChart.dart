// ignore: file_names
import 'dart:math';
import "package:flutter/material.dart";
import 'package:fl_chart/fl_chart.dart';
import 'package:unicoin/services/api.dart';

class LineChartWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final String id;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: Api().getCoinHistoryIn7Days(id, DateTime.now()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            var data = snapshot.data!;
            if (data.length != 7) return Container();
            double highestY = 0;
            List<FlSpot> spots = [];
            for (int i = 0; i < data.length; i++) {
              highestY =
                  max(highestY, data[i]["market_data"]["current_price"]["usd"]);
              spots.add(FlSpot(i.toDouble(),
                  data[i]["market_data"]["current_price"]["usd"]));
            }
            highestY = highestY * 5 / 4;
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border:
                          Border.all(color: const Color(0xff37434d), width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        colors: gradientColors,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Container();
        });
  }
}
