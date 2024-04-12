import 'package:equatable/equatable.dart';
import 'package:translator/model/country.dart';

abstract class TranslateToState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TranslateToStateInitial extends TranslateToState {
  @override
  List<Object?> get props => [];
}

final class TranslateToStatelanguage extends TranslateToState {
  final Country language;
  TranslateToStatelanguage({required this.language});
  @override
  List<Object?> get props => [language];
}

final class TranslateToStateError extends TranslateToState {
  final String error;
  TranslateToStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
