import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglextest/bloc/verify_account/bloc.dart';
import 'package:hagglextest/bloc/verify_account/event.dart';
import 'package:hagglextest/bloc/verify_account/state.dart';
import 'package:hagglextest/repository/api.dart';
import 'package:hagglextest/screens/dashboard/dashboard.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';
import 'setup_complete_screen.dart';

class VerifyAccountScreen extends StatefulWidget {
  final dynamic resultData;
  final String? screen;
  const VerifyAccountScreen({Key? key, this.resultData, this.screen})
      : super(key: key);

  @override
  _VerifyAccountScreenState createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  Timer? _timer;
  int _start = 10;
  bool? canResendCode = false;
  bool? isSending = false;
  bool? isVerifying = false;

  VerifyAccountBloc? verifyAccountBloc;
  TextEditingController _codeController = TextEditingController();

  void startTimer() {
    _start = 10;
    canResendCode = false;
    const oneMin = const Duration(minutes: 1);
    _timer = new Timer.periodic(
      oneMin,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            canResendCode = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    verifyAccountBloc = BlocProvider.of<VerifyAccountBloc>(context);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: 10, right: 10, top: queryData.size.height * 0.06),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_alt.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocListener<VerifyAccountBloc, VerifyAccountState>(
          listener: (context, state) {
            if (state is VerifyingState) {
              setState(() {
                isVerifying = true;
              });
            } else if (state is VerifiedState) {
              setState(() {
                isVerifying = false;
              });

              _codeController.clear();
              Fluttertoast.showToast(
                  msg: 'Verification Successful',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);

              if (widget.screen == 'register') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => SetupCompleteScreen()));
              } else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Dashboard()));
              }
            } else if (state is ErrorState) {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);
            } else {
              setState(() {
                isVerifying = false;
              });
            }
          },
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
                height: queryData.size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Verify your account',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: queryData.size.height * 0.02,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: queryData.size.height * 0.03,
                        ),
                        Image.asset('assets/light_done_icon.png', height: 64),
                        SizedBox(
                          height: queryData.size.height * 0.05,
                        ),
                        Text(
                          'We just sent a verfication code to your email.',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        Text(
                          'Please enter the code',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.04,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _codeController,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              labelText: "Verification code",
                              labelStyle:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                onPressed: () async {
                                  verifyAccountBloc!.add(VerifyEvent(
                                      code: _codeController.text,
                                      email: widget.resultData['email']));
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Container(
                                  height: 50,
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      gradient: new LinearGradient(
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColor2
                                        ],
                                      )),
                                  child: Center(
                                    child: Text(
                                      "VERIFY ME",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.05,
                        ),
                        Text(
                          'The code will expire in ${_start} mins',
                          style: AppStyles.onboardinTextStyle
                              .copyWith(fontSize: 10, color: Colors.black87),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.04,
                        ),
                        Visibility(
                          visible: canResendCode!,
                          child: isSending!
                              ? Text('sending code..')
                              : GestureDetector(
                                  onTap: () async {
                                    var userEmail = widget.resultData['login']
                                            ['user']['email']
                                        .toString();
                                    print('the email ' + userEmail);
                                    setState(() {
                                      isSending = true;
                                    });
                                    var queryOptions = QueryOptions(
                                      document: gql(ResendVerificationCode),
                                      variables: {"email": userEmail},
                                      pollInterval: Duration(seconds: 10),
                                    );
                                    await client.value
                                        .query(queryOptions)
                                        .then((value) {
                                      print(value.exception.toString());
                                      setState(() {
                                        isSending = false;
                                      });
                                      if (!value.hasException) {
                                        startTimer();
                                      } else {
                                        print(
                                            'could not resend code at this time');
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Resend Code',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.09,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ), //place where the image appears
    );
  }
}
