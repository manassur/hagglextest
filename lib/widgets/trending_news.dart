import 'package:flutter/material.dart';

class TrendingCryptoNewsWidget extends StatefulWidget {
  const TrendingCryptoNewsWidget({Key? key}) : super(key: key);

  @override
  _TrendingCryptoNewsWidgetState createState() =>
      _TrendingCryptoNewsWidgetState();
}

class _TrendingCryptoNewsWidgetState extends State<TrendingCryptoNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 10),
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 70,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/6765373/pexels-photo-6765373.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                            )),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Blockchain  Bites: BTC on Ethereum, DeFi's latest stable coin, the currency cold wars",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  "6hrs ",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 10),
                                ),
                                Text(
                                  "ago ",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Category: ",
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      "DeFi",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 10),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ));
  }
}
