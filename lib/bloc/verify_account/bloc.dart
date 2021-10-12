import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglextest/repository/api.dart';
import 'package:hagglextest/repository/cache.dart';
import 'event.dart';
import 'state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  @override
  VerifyAccountState get initialState => InitialState();

  @override
  Stream<VerifyAccountState> mapEventToState(VerifyAccountEvent event) async* {
    if (event is VerifyEvent) {
      yield VerifyingState();
      if (event.code!.isEmpty) {
        yield ErrorState(error: 'please enter your verification code');
      } else {
        try {
          var mutationOptions = MutationOptions(
            document: gql(twofactorLogin),
            variables: {"email": event.email, 'totpCode': event.code},
          );
          var result = await client.value.mutate(mutationOptions);
          print(result.exception.toString());
          if (result.isLoading) {
            yield VerifyingState();
          } else if (result.hasException) {
            print('could not resend code at this time');
            var error = result.exception!.graphqlErrors[0]
                .extensions!['exception']['response'];
            yield ErrorState(error: error['message']);
          } else {
            yield VerifiedState(data: result.data);
            // save the verified user to cache
            AppCache.saveUser(result.data);
          }
        } catch (e) {
          yield ErrorState(error: e.toString());
        }
      }
    }
  }
}
