import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hagglextest/utility/colors.dart';

class MarketsWidget extends StatefulWidget {
  const MarketsWidget({Key? key}) : super(key: key);

  @override
  _MarketsWidgetState createState() => _MarketsWidgetState();
}

class _MarketsWidgetState extends State<MarketsWidget> {
  List<Color> gradientColors = [
    AppColors.primaryColor,
    Colors.yellow,
    Colors.black54,
    Colors.green,
    Colors.orangeAccent,
    Colors.blueAccent
  ];

  List<String> assets = [
    'haggle_icon.png',
    '001-bitcoin.png',
    '003-digital-currency.png',
    '002-tether.png',
    'dogecoin.png',
    'litecoin.png',
  ];

  List<String> coins = [
    'HaggleX (HAG)',
    'Bitcoin (BTC)',
    'Etherum (ETH)',
    'Tether (USDT)',
    'Dogecoin (DOGE)',
    'Litecoin (LTC)',
  ];

  final List<double> yValues = [1.3, 1, 1.8, 1.5, 2.2, 1.8, 3];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade50,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade50,
                        child: Image.asset(
                          'assets/${assets[index]}',
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(coins[index],
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "NGN",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12),
                          ),
                          Text(
                            "3,454,857.00 ",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12),
                          ),
                          SizedBox(width: 2),
                          Text(
                            "+2.34%",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        height: 20,
                        width: 80,
                        child: LineChart(
                          mainChart(gradientColors[index]),
                          swapAnimationDuration:
                              Duration(milliseconds: 150), // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          tileMode: TileMode.clamp,
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 0.2),
                          colors: [
                            gradientColors[index].withOpacity(0.09),
                            gradientColors[index].withOpacity(0.08),
                            gradientColors[index].withOpacity(0.06),
                            gradientColors[index].withOpacity(0.04),
                            gradientColors[index].withOpacity(0.03),
                            gradientColors[index].withOpacity(0.02),
                            gradientColors[index].withOpacity(0.01),
                            gradientColors[index].withOpacity(0.0),
                          ],
                        )),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey.shade300,
            );
          },
        ));
  }

  LineChartData mainChart(Color color) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: false,
          colors: [
            color,
          ],
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [color].map((color) => color.withOpacity(0.1)).toList(),
          ),
        ),
      ],
    );
  }
}
