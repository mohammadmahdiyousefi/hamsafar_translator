part of 'translator_bloc.dart';

sealed class TranslatorEvent extends Equatable {
  const TranslatorEvent();

  @override
  List<Object> get props => [];
}

final class TranslatorEventInitial extends TranslatorEvent {}

final class TranslatorEventTranslate extends TranslatorEvent {
  final String? text;
  const TranslatorEventTranslate({this.text});
}

final class TranslatorEventSetFrom extends TranslatorEvent {
  final Country? from;
  const TranslatorEventSetFrom({this.from});
}

final class TranslatorEventSetTo extends TranslatorEvent {
  final Country? to;
  const TranslatorEventSetTo({this.to});
}

final class TranslatorEventChangeLanguage extends TranslatorEvent {}
