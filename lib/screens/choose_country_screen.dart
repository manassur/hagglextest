import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglextest/repository/api.dart';
import 'package:hagglextest/utility/styles.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({Key? key}) : super(key: key);

  @override
  _ChooseCountryScreenState createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: 20, right: 20, top: queryData.size.height / 8),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_alt.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              child: TextField(
                style: AppStyles.onboardinTextStyle,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    fillColor: Colors.white.withOpacity(0.2),
                    labelText: "Search for country",
                    labelStyle:
                        AppStyles.onboardinTextStyle2.copyWith(fontSize: 14),
                    hintText: 'Search for country',
                    hintStyle: AppStyles.onboardinTextStyle2
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.3),
                    )),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Query(
                options: QueryOptions(
                  document: gql(getCountriesQuery),
                  pollInterval: Duration(seconds: 10),
                ),
                builder: (QueryResult? result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result!.hasException) {
                    return Text(
                      result.exception.toString(),
                    );
                  }

                  if (result.isLoading) {
                    return Center(
                        child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white))));
                  }

                  // it can be either Map or List
                  List repositories = result.data!['getActiveCountries'];

                  return ListView.builder(
                      itemCount: repositories.length,
                      itemBuilder: (context, index) {
                        final repository = repositories[index];

                        return ListTile(
                          leading: SvgPicture.network(
                            repository['flag'] + '?access_key=',
                            placeholderBuilder: (context) => Container(
                              height: 30,
                              width: 40,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            height: 20.0,
                          ),
                          title: Text(
                            '(+${repository['callingCode']}) ${repository['name']}',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pop(context, repository);
                          },
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
