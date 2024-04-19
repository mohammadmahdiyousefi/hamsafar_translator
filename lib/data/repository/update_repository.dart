import 'package:dartz/dartz.dart';
import 'package:translator/data/datasource/update_datasourc.dart';
import 'package:translator/di/di.dart';
import 'package:translator/model/updatemodel.dart';

abstract class IUpdateRepository {
  Future<Either<String, List<UpdateModel>>> getUpadate();
}

class UpdateRepository extends IUpdateRepository {
  final IUpdateDatasource _datasours = locator.get();

  @override
  Future<Either<String, List<UpdateModel>>> getUpadate() async {
    try {
      var respons = await _datasours.getUpdate();
      return right(respons);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
