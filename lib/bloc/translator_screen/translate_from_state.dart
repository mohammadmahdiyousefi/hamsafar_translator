import 'package:equatable/equatable.dart';
import 'package:translator/model/country.dart';

abstract class TranslateFromState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TranslateFromStateInitial extends TranslateFromState {
  @override
  List<Object?> get props => [];
}

final class TranslateFromStatelanguage extends TranslateFromState {
  final Country language;
  TranslateFromStatelanguage({required this.language});
  @override
  List<Object?> get props => [language];
}

final class TranslateFromStateError extends TranslateFromState {
  final String error;
  TranslateFromStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
