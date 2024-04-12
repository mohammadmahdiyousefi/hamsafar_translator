import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/bloc/translator_screen/translate_from_state.dart';
import 'package:translator/bloc/translator_screen/translate_result_state.dart';
import 'package:translator/bloc/translator_screen/translator_to_state.dart';
import 'package:translator/model/country.dart';
import 'package:translator_plus/translator_plus.dart';

part 'translator_event.dart';
part 'translator_state.dart';

class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  Country? from;
  Country? to;
  String text = "";
  String result = "";
  final GoogleTranslator translator = GoogleTranslator();
  TranslatorBloc()
      : super(TranslatorState(
          from: TranslateFromStateInitial(),
          to: TranslateToStateInitial(),
          result: TranslateResultStateInitial(),
        )) {
    on<TranslatorEventInitial>(
      (event, emit) async {
        try {
          from = await getFromLanguage();
          if (from != null) {
            emit(
              state.copyWith(
                newfrom: TranslateFromStatelanguage(language: from!),
              ),
            );
          } else {
            emit(
              state.copyWith(
                newfrom: TranslateFromStateInitial(),
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              newfrom: TranslateFromStateError(
                error: e.toString(),
              ),
            ),
          );
        }
        try {
          to = await getToLanguage();
          if (to != null) {
            emit(
              state.copyWith(
                newto: TranslateToStatelanguage(language: to!),
              ),
            );
          } else {
            emit(
              state.copyWith(
                newto: TranslateToStateInitial(),
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              newto: TranslateToStateError(
                error: e.toString(),
              ),
            ),
          );
        }
        emit(state.copyWith(newresult: TranslateResultStateEmpty()));
      },
    );
    on<TranslatorEventSetFrom>(
      (event, emit) async {
        from = event.from;
        if (from != null) {
          await saveFromLanguage(from!).then(
            (value) {
              if (value == true) {
                emit(
                  state.copyWith(
                    newfrom: TranslateFromStatelanguage(language: from!),
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    newfrom: TranslateFromStateError(
                        error: "Something went wrong to set language"),
                  ),
                );
              }
            },
          );
        }
      },
    );
    on<TranslatorEventSetTo>(
      (event, emit) async {
        to = event.to;
        if (to != null) {
          await saveToLanguage(to!).then(
            (value) {
              if (value == true) {
                emit(state.copyWith(
                  newto: TranslateToStatelanguage(language: to!),
                ));
              } else {
                emit(
                  state.copyWith(
                    newto: TranslateToStateError(
                        error: "Something went wrong to set language"),
                  ),
                );
              }
            },
          );
        }
      },
    );
    on<TranslatorEventTranslate>((event, emit) async {
      text = event.text ?? text;
      if (from == null || to == null) {
        result = "";
        emit(
          state.copyWith(
            newresult: TranslateResultStateEmpty(),
          ),
        );
      } else {
        if (text.isEmpty) {
          result = "";
          emit(
            state.copyWith(
              newresult: TranslateResultStateEmpty(),
            ),
          );
        } else {
          try {
            emit(state.copyWith(newresult: TranslateResultStateLoading()));
            await translator
                .translate(text, from: from!.code, to: to!.code)
                .then((value) {
              result = value.text;
            });
            emit(
              state.copyWith(
                newresult: TranslateResultStateSuccess(
                    result: result, textDirection: to!.textDirection),
              ),
            );
          } catch (ex) {
            emit(
              state.copyWith(
                newresult: TranslateResultStateError(
                  error: ex.toString(),
                ),
              ),
            );
          }
        }
      }
    });
    on<TranslatorEventChangeLanguage>((event, emit) async {
      if (from == null || to == null) {
      } else {
        if (from!.name != "Auto") {
          Country change = from!;
          from = to;
          to = change;
          await saveToLanguage(to!).then((value) {
            if (value == true) {
              emit(state.copyWith(
                newto: TranslateToStatelanguage(language: to!),
              ));
            } else {
              emit(
                state.copyWith(
                  newto: TranslateToStateError(
                      error: "Something went wrong to set language"),
                ),
              );
            }
          });
          await saveFromLanguage(from!).then((value) {
            if (value == true) {
              emit(state.copyWith(
                newfrom: TranslateFromStatelanguage(language: from!),
              ));
            } else {
              emit(
                state.copyWith(
                  newfrom: TranslateFromStateError(
                      error: "Something went wrong to set language"),
                ),
              );
            }
          });
          text = result;
          result = '';
          if (text.isNotEmpty) {
            try {
              emit(state.copyWith(newresult: TranslateResultStateLoading()));
              await translator
                  .translate(text, from: from!.code, to: to!.code)
                  .then((value) {
                result = value.text;
              });
              emit(
                state.copyWith(
                  newresult: TranslateResultStateSuccess(
                      result: result, textDirection: to!.textDirection),
                ),
              );
            } catch (ex) {
              emit(
                state.copyWith(
                  newresult: TranslateResultStateError(
                    error: ex.toString(),
                  ),
                ),
              );
            }
          }
        }
      }
    });
  }
  Future<bool> saveFromLanguage(Country fromLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result =
        await prefs.setString("fromLanguage", jsonEncode(fromLanguage.getMap));
    return result;
  }

  Future<bool> saveToLanguage(Country toLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result =
        await prefs.setString("toLanguage", jsonEncode(toLanguage.getMap));

    return result;
  }

  Future<Country?> getFromLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fromLanguage = prefs.getString("fromLanguage");
    if (fromLanguage != null) {
      return Country.fromjson(jsonDecode(fromLanguage));
    } else {
      return null;
    }
  }

  Future<Country?> getToLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? toLanguage = prefs.getString("toLanguage");
    if (toLanguage != null) {
      return Country.fromjson(jsonDecode(toLanguage));
    } else {
      return null;
    }
  }
}
