import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: HttpLink('https://api-staging.hagglex.com/graphql'),
  ),
);

final String getCountriesQuery = """
query {
  getActiveCountries {
    _id,
    name,
    alpha2Code,
    flag,
    callingCode,
    currencyCode
  }
}
""";

final String ResendVerificationCode = """
query resendVerificationCode( \$email:String!){
  resendVerificationCode(data:{email:\$email})
}
""";

final String loginUserMutation = """
mutation Login(  \$input:String!, \$password:String!){
  login(data:{input:\$input,password:\$password })
  {
    user{
      _id,email,username,phonenumber
    },
    token,
    twoFactorAuth,
    __typename
  }
}
""";

final String twofactorLogin = """
mutation TwoFALogin( \$email:String!, \$totpCode:String!){
  twoFALogin(data:{email:\$email,totpCode:\$totpCode })
  {
    user{
      _id,email,username,phonenumber
    },
    token,
  }
}
""";

final String createAccountMutation = """
mutation Register ( \$email:String!,\$username:String!,\$password:String!,\$phone:String!,\$ref:String!,\$country:String! ,\$currency:String!){
  register(
    data: {
      email:\$email,
      username:\$username,
      password:\$password,
      phonenumber:\$phone,
      referralCode:\$ref,
      country:\$country,
      currency:\$currency
    }){
    user{
      _id,email,username,phonenumber
    },
    token,
  }
}
""";


