part of 'updateversion_bloc.dart';

sealed class UpdateversionEvent extends Equatable {
  const UpdateversionEvent();

  @override
  List<Object> get props => [];
}

class GetUpadate extends UpdateversionEvent {
  const GetUpadate();
}
