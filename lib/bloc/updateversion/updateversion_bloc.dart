import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:translator/data/repository/update_repository.dart';
import 'package:translator/di/di.dart';
import 'package:translator/model/updatemodel.dart';

part 'updateversion_event.dart';
part 'updateversion_state.dart';

class UpdateversionBloc extends Bloc<UpdateversionEvent, UpdateversionState> {
  final IUpdateRepository _repository = locator.get();
  UpdateversionBloc() : super(UpdateversionInitial()) {
    on<GetUpadate>((event, emit) async {
      emit(UpdateversionLoading());
      var respons = await _repository.getUpadate();
      respons.fold((error) {
        emit(UpdateversionError(error));
      }, (data) {
        emit(UpdateversionData(data[0]));
      });
    });
  }
}
