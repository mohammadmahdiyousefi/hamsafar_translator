part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  final ConversationFromState from;
  final ConversationToState to;
  final ConversationFromFildState fromfild;
  final ConversationToFildState tofild;
  const ConversationState(
      {required this.from,
      required this.to,
      required this.fromfild,
      required this.tofild});
  ConversationState copyWith(
      {ConversationFromState? newfrom,
      ConversationToState? newto,
      ConversationFromFildState? newfromfild,
      ConversationToFildState? newtofild}) {
    return ConversationState(
        from: newfrom ?? from,
        to: newto ?? to,
        fromfild: newfromfild ?? fromfild,
        tofild: newtofild ?? tofild);
  }

  @override
  List<Object> get props => [from, to, fromfild, tofild];
}
