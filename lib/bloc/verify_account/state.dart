import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class VerifyAccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends VerifyAccountState {
  @override
  List<Object> get props => [];
}

class VerifyingState extends VerifyAccountState {
  @override
  List<Object> get props => [];
}

class ErrorState extends VerifyAccountState {
  final String? error;

  ErrorState({@required this.error});

  @override
  List<Object> get props => [];
}

class VerifiedState extends VerifyAccountState {
  dynamic data;
  VerifiedState({@required this.data});
  @override
  List<Object> get props => [];
}
