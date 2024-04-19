part of 'updateversion_bloc.dart';

sealed class UpdateversionState extends Equatable {
  const UpdateversionState();

  @override
  List<Object> get props => [];
}

final class UpdateversionInitial extends UpdateversionState {}

final class UpdateversionLoading extends UpdateversionState {}

final class UpdateversionData extends UpdateversionState {
  final UpdateModel data;
  const UpdateversionData(this.data);
  @override
  List<Object> get props => [data];
}

final class UpdateversionError extends UpdateversionState {
  final String error;
  const UpdateversionError(this.error);
  @override
  List<Object> get props => [error];
}
