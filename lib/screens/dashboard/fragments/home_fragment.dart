import 'package:flutter/material.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';
import 'package:hagglextest/widgets/custom_switch.dart';
import 'package:hagglextest/widgets/do_more.dart';
import 'package:hagglextest/widgets/markets_widget.dart';
import 'package:hagglextest/widgets/trending_news.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  bool isNaira = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: queryData.size.height>800? Size.fromHeight(queryData.size.height * 0.2):Size.fromHeight(queryData.size.height * 0.3),
        child: AppBar(
          leading: Container(),
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/appbar_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: queryData.size.height * 0.06),
                    Row(
                      children: [
                        CircleAvatar(
                          child: CircleAvatar(
                            child: CircleAvatar(
                              child: Text(
                                'SV',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              backgroundColor: AppColors.lightPurpleColor,
                              radius: 20,
                            ),
                            backgroundColor: AppColors.primaryColor,
                            radius: 23,
                          ),
                          backgroundColor: Colors.white,
                          radius: 24,
                        ),
                        Text(
                          'HaggleX',
                          style: AppStyles.onboardinTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                backgroundColor: Colors.white.withOpacity(0.1),
                                radius: 15,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: CircleAvatar(
                                child: Text('5',
                                    style: AppStyles.onboardinTextStyle
                                        .copyWith(fontSize: 12)),
                                backgroundColor: AppColors.redColor,
                                radius: 8,
                              ),
                            )
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(height: queryData.size.height * 0.04),
                    Text(
                      'Total portfolio balance',
                      style: AppStyles.onboardinTextStyle
                          .copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: queryData.size.height * 0.02),
                    Row(
                      children: [
                        isNaira == true
                            ? Text(
                                '\u{20A6}****',
                                style: AppStyles.onboardinTextStyle.copyWith(
                                    fontSize: 30, fontWeight: FontWeight.w400),
                              )
                            : Text(
                                '\$****',
                                style: AppStyles.onboardinTextStyle.copyWith(
                                    fontSize: 30, fontWeight: FontWeight.w400),
                              ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(3),
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: CustomSwitch(
                                  text: 'USD',
                                  isSelected: !isNaira,
                                ),
                                onTap: () {
                                  setState(() {
                                    isNaira = !isNaira;
                                  });
                                },
                              ),
                              GestureDetector(
                                child: CustomSwitch(
                                  text: 'NGN',
                                  isSelected: isNaira,
                                ),
                                onTap: () {
                                  setState(() {
                                    isNaira = !isNaira;
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              margin: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Image.asset('assets/banner1.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset('assets/banner2.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset('assets/banner3.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset('assets/banner4.png'),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Markets",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MarketsWidget(),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Do more with HaggleX",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DoMoreWidget(),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Trending crypto news",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TrendingCryptoNewsWidget(),
            Divider(),
            ListTile(
              title: Text('View all stories'),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
