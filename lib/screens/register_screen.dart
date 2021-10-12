import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglextest/bloc/verify_account/bloc.dart';
import 'package:hagglextest/repository/api.dart';
import 'package:hagglextest/screens/verify_account_screen.dart';
import 'package:hagglextest/utility/colors.dart';
import 'package:hagglextest/utility/styles.dart';

import 'choose_country_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var selectedCountry;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _referralCodeController = TextEditingController();

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
            Mutation(
              options: MutationOptions(
                document: gql(createAccountMutation),
                // or do something with the result.data on completion
                onCompleted: (dynamic resultData) async {
                  if (resultData != null) {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider<VerifyAccountBloc>(
                                    create: (context) => VerifyAccountBloc(),
                                    child: VerifyAccountScreen(
                                      resultData: resultData,
                                      screen: 'register',
                                    ))));

                    print(resultData);
                  } else {}
                },
              ),
              builder: (RunMutation? runMutation, QueryResult? result) {
                print(result!.exception.toString());
                var errors;
                if (result.exception != null) {
                  errors = result.exception!.graphqlErrors[0]
                      .extensions!['exception']['response'];
                }
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: queryData.size.height * 0.08,
                        bottom: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create a new account',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              cursorColor: AppColors.primaryColor,
                              controller: _emailController,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                errorText:
                                    errors != null && errors['email'] != null
                                        ? errors['email'][0]
                                        : null,
                                labelStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
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
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              cursorColor: AppColors.primaryColor,
                              controller: _passwordController,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Password (Min. 8 characters)",
                                errorText:
                                    errors != null && errors['password'] != null
                                        ? errors['password'][0]
                                        : null,
                                labelStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              cursorColor: AppColors.primaryColor,
                              controller: _usernameController,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "Create a username",
                                errorText:
                                    errors != null && errors['username'] != null
                                        ? errors['username'][0]
                                        : null,
                                labelStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.black),
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
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChooseCountryScreen()));
                              // get the user's country selection
                              if (result != null) {
                                setState(() {
                                  selectedCountry = result;
                                });
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(right: 8),
                                      child: selectedCountry == null
                                          ? Center(child: Text('Country'))
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  selectedCountry['flag'],
                                                  errorBuilder: (BuildContext?
                                                          context,
                                                      Object? exception,
                                                      StackTrace? stackTrace) {
                                                    return Container(
                                                      height: 15,
                                                      width: 20,
                                                      color: Colors.grey,
                                                    );
                                                  },
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '(+${selectedCountry['callingCode']})',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.08),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                              color: Colors.black54,
                                              width: 0.5)),
                                    )),
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      cursorColor: AppColors.primaryColor,
                                      controller: _phoneController,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Enter your phone number",
                                        errorText:
                                            // check for country errors first
                                            errors != null
                                                ? errors['country'] != null
                                                    ? errors['country'][0]
                                                    : errors['phonenumber'] !=
                                                            null
                                                        ? errors['phonenumber']
                                                            [0]
                                                        : null
                                                : null,
                                        labelStyle: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        hintStyle: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextField(
                              cursorColor: AppColors.primaryColor,
                              controller: _referralCodeController,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black45),
                              decoration: InputDecoration(
                                labelText: "Referral code (optional)",
                                errorText: errors != null &&
                                        errors['referralCode'] != null
                                    ? errors['referralCode'][0]
                                    : null,
                                labelStyle: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black45),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black45),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegisterScreen()));
                                },
                                child: Text(
                                  'By signing, you agree to HaggleX terms and privacy policy.',
                                  style: AppStyles.onboardinTextStyle.copyWith(
                                      fontSize: 10, color: Colors.black87),
                                ),
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
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () async {
                              runMutation!({
                                'email': _emailController.text,
                                'username': _usernameController.text,
                                'password': _passwordController.text,
                                'phone': _phoneController.text,
                                'ref': _referralCodeController.text,
                                'country': selectedCountry == null
                                    ? ''
                                    : selectedCountry['_id'],
                                'currency': selectedCountry == null
                                    ? ''
                                    : selectedCountry['currencyCode']
                              });
                            },
                            textColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  gradient: new LinearGradient(
                                    colors: [
                                      AppColors.primaryColor,
                                      AppColors.primaryColor2
                                    ],
                                  )),
                              child: Center(
                                child: result.isLoading
                                    ? SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white)))
                                    : Text(
                                        "SIGN UP",
                                        style: TextStyle(fontSize: 10),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ), //place where the image appears
    );
  }
}
