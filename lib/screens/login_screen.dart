import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglextest/bloc/verify_account/bloc.dart';
import 'package:hagglextest/screens/verify_account_screen.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';
import 'package:hagglextest/repository/api.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
        body: Mutation(
            options: MutationOptions(
              document: gql(loginUserMutation),
              // or do something with the result.data on completion

              onCompleted: (dynamic resultData) async {
                print(resultData);
                if (resultData != null) {
                  _emailController.clear();
                  _passwordController.clear();
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider<VerifyAccountBloc>(
                              create: (context) => VerifyAccountBloc(),
                              child: VerifyAccountScreen(
                                resultData: resultData,
                                screen: 'login',
                              ))));
                }
              },
            ),
            builder: (RunMutation? runMutation, QueryResult? result) {
              //  print(result!.exception.toString());
              var errors;
              if (result!.exception != null) {
                errors = result.exception!.graphqlErrors[0]
                    .extensions!['exception']['response'];
              }

              return Container(
                padding: EdgeInsets.only(
                    left: 40, right: 40, top: queryData.size.height / 5),
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
                    Text(
                      'Welcome!',
                      style: AppStyles.onboardinTextStyle
                          .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _emailController,
                        style: AppStyles.onboardinTextStyle,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          errorText: errors != null && errors['input'] != null
                              ? errors['input'][0]
                              : null,
                          labelStyle: AppStyles.onboardinTextStyle2
                              .copyWith(fontSize: 12),
                          hintStyle: AppStyles.onboardinTextStyle2
                              .copyWith(fontSize: 12),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _passwordController,
                        style: AppStyles.onboardinTextStyle,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          errorText:
                              errors != null && errors['password'] != null
                                  ? errors['password'][0]
                                  : null,
                          labelText: "Password (Min. 8 characters)",
                          labelStyle: AppStyles.onboardinTextStyle2
                              .copyWith(fontSize: 12),
                          hintStyle: AppStyles.onboardinTextStyle2
                              .copyWith(fontSize: 12),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: AppStyles.onboardinTextStyle
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errors != null && errors['message'] != null
                              ? errors['message']
                              : '',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            height: 50,
                            elevation: 0,
                            color: AppColors.accentColor,
                            child: result.isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                AppColors.brownColor)))
                                : new Text('LOG IN',
                                    style: new TextStyle(
                                        fontSize: 12.0,
                                        color: AppColors.brownColor)),
                            onPressed: () async {
                              runMutation!({
                                'input': _emailController.text,
                                'password': _passwordController.text
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterScreen()));
                          },
                          child: Text(
                            'New User? Create a new account',
                            style: AppStyles.onboardinTextStyle
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
