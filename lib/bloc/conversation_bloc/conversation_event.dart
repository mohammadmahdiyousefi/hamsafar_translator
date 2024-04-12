part of 'conversation_bloc.dart';

sealed class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class ConversationEventInitial extends ConversationEvent {}

class ConversationSetFrom extends ConversationEvent {
  final Country language;
  const ConversationSetFrom(this.language);
  @override
  List<Object> get props => [language];
}

class ConversationSetTo extends ConversationEvent {
  final Country language;
  const ConversationSetTo(this.language);
  @override
  List<Object> get props => [language];
}

class TranslateFromIntoTo extends ConversationEvent {
  final String text;
  const TranslateFromIntoTo(this.text);
  @override
  List<Object> get props => [text];
}

class TranslateToIntoFrom extends ConversationEvent {
  final String text;
  const TranslateToIntoFrom(this.text);
  @override
  List<Object> get props => [text];
}
