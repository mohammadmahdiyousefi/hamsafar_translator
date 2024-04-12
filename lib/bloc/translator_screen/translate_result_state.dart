import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TranslateResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TranslateResultStateInitial extends TranslateResultState {}

final class TranslateResultStateLoading extends TranslateResultState {}

final class TranslateResultStateEmpty extends TranslateResultState {}

final class TranslateResultStateSuccess extends TranslateResultState {
  final String result;
  final TextDirection textDirection;
  TranslateResultStateSuccess(
      {required this.result, required this.textDirection});
  @override
  List<Object?> get props => [result, textDirection];
}

final class TranslateResultStateError extends TranslateResultState {
  final String error;
  TranslateResultStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
