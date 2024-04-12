import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class ConversationToFildState extends Equatable {
  const ConversationToFildState();

  @override
  List<Object> get props => [];
}

class ConversationToFildInitial extends ConversationToFildState {}

class ConversationToFildLoading extends ConversationToFildState {}

class ConversationToFilddata extends ConversationToFildState {
  final String data;
  final TextDirection direction;
  const ConversationToFilddata(this.data, this.direction);
  @override
  List<Object> get props => [data, direction];
}

class ConversationToFildError extends ConversationToFildState {
  final String error;
  const ConversationToFildError(this.error);
  @override
  List<Object> get props => [error];
}
