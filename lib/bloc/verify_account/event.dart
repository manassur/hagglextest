import 'package:equatable/equatable.dart';

abstract class VerifyAccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//postComment event
class VerifyEvent extends VerifyAccountEvent {
  String? code, email;
  VerifyEvent({this.code, this.email});
  @override
  List<Object> get props => [];
}
