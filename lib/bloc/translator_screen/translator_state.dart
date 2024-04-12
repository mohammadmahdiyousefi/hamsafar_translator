part of 'translator_bloc.dart';

class TranslatorState {
  final TranslateFromState from;
  final TranslateToState to;
  final TranslateResultState result;
  const TranslatorState(
      {required this.from, required this.to, required this.result});
  TranslatorState copyWith(
      {TranslateFromState? newfrom,
      TranslateToState? newto,
      TranslateResultState? newresult}) {
    return TranslatorState(
        from: newfrom ?? from, to: newto ?? to, result: newresult ?? result);
  }
}
