import "package:flutter/material.dart";
import 'package:fl_chart/fl_chart.dart';
import 'package:unicoin/services/api.dart';

class LineChartWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final String id;
  final int days;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartWidget({Key? key, required this.id, required this.days})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: Api().getCoinHistory(id, days),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            var data = snapshot.data!;
            List<FlSpot> spots = [];
            for (int i = 0; i < data["prices"].length; i++) {
              spots.add(FlSpot(i.toDouble(), data["prices"][i][1]));
            }
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(show: false),
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
