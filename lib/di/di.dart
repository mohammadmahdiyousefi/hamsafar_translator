import 'package:get_it/get_it.dart';
import 'package:translator/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:translator/bloc/translator_screen/translator_bloc.dart';
import 'package:translator/data/datasource/update_datasourc.dart';
import 'package:translator/data/repository/update_repository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //TranslatorBloc
  locator.registerSingleton(TranslatorBloc());
  locator.registerSingleton(ConversationBloc());

  //datasourc
  locator.registerFactory<IUpdateDatasource>(() => UpdateDatasource());

  //repository
  locator.registerFactory<IUpdateRepository>(() => UpdateRepository());
}
