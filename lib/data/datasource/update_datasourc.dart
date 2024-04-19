import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:translator/model/updatemodel.dart';

abstract class IUpdateDatasource {
  Future<List<UpdateModel>> getUpdate();
}

class UpdateDatasource extends IUpdateDatasource {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.github.com/'));
  final String clientId = '133e06b5854418843fd2';
  final String clientSecret = '78fc94a9131db119b896b744207b9efafdab6c0f';
  @override
  Future<List<UpdateModel>> getUpdate() async {
    final authorizationHeader =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';
    final options = Options(
      headers: {'Authorization': authorizationHeader},
    );

    try {
      var response = await _dio.get(
          "repos/mohammadmahdiyousefi/hamsafar_translator/releases",
          options: options);
      return response.data
          .map<UpdateModel>((jsonObject) => UpdateModel.fromJson(jsonObject))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
