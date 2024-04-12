import 'package:equatable/equatable.dart';
import 'package:translator/model/country.dart';

abstract class ConversationFromState extends Equatable {
  const ConversationFromState();

  @override
  List<Object> get props => [];
}

class ConversationFromInitial extends ConversationFromState {}

class ConversationFromdata extends ConversationFromState {
  final Country language;
  const ConversationFromdata({required this.language});
  @override
  List<Object> get props => [language];
}

class ConversationFromError extends ConversationFromState {
  final String error;
  const ConversationFromError({required this.error});
  @override
  List<Object> get props => [error];
}
