import 'package:equatable/equatable.dart';
import 'package:translator/model/country.dart';

abstract class ConversationToState extends Equatable {
  const ConversationToState();

  @override
  List<Object> get props => [];
}

class ConversationToInitial extends ConversationToState {}

class ConversationTodata extends ConversationToState {
  final Country language;
  const ConversationTodata({required this.language});
  @override
  List<Object> get props => [language];
}

class ConversationToError extends ConversationToState {
  final String error;
  const ConversationToError({required this.error});
  @override
  List<Object> get props => [error];
}
