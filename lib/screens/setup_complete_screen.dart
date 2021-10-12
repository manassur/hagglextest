import 'package:flutter/material.dart';
import 'package:hagglextest/screens/dashboard/dashboard.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';

class SetupCompleteScreen extends StatefulWidget {
  const SetupCompleteScreen({Key? key}) : super(key: key);

  @override
  _SetupCompleteScreenState createState() => _SetupCompleteScreenState();
}

class _SetupCompleteScreenState extends State<SetupCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: 10, right: 10, top: queryData.size.height * 0.08),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  padding:
                      EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
            SizedBox(
              height: queryData.size.height * 0.05,
            ),
            Container(
              height: queryData.size.height * 0.7,
              padding: EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset('assets/gradient_done_icon.png', height: 64),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Setup Complete',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Thank you for setting up your HaggleX account',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            height: 50,
                            elevation: 0,
                            color: AppColors.accentColor,
                            child: new Text('START EXPLORING',
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.brownColor)),
                            onPressed: () async {
                              await Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Dashboard()));
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ), //place where the image appears
    );
  }
}
