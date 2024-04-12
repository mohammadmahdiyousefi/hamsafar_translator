import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConversationFromFildState extends Equatable {
  const ConversationFromFildState();

  @override
  List<Object> get props => [];
}

class ConversationFromFildInitial extends ConversationFromFildState {}

class ConversationFromFildLoading extends ConversationFromFildState {}

class ConversationFromFilddata extends ConversationFromFildState {
  final String data;
  final TextDirection direction;
  const ConversationFromFilddata(this.data, this.direction);
  @override
  List<Object> get props => [data, direction];
}

class ConversationFromFildError extends ConversationFromFildState {
  final String error;
  const ConversationFromFildError(this.error);
  @override
  List<Object> get props => [error];
}
