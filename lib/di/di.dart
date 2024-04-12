import 'package:get_it/get_it.dart';
import 'package:translator/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:translator/bloc/translator_screen/translator_bloc.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //TranslatorBloc
  locator.registerSingleton(TranslatorBloc());
  locator.registerSingleton(ConversationBloc());
}
