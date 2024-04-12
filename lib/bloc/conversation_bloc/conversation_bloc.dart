import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/bloc/conversation_bloc/conversation_from.dart';
import 'package:translator/bloc/conversation_bloc/conversation_from_fild.dart';
import 'package:translator/bloc/conversation_bloc/conversation_to.dart';
import 'package:translator/bloc/conversation_bloc/conversation_to_fild.dart';
import 'package:translator/model/country.dart';
import 'package:translator_plus/translator_plus.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  Country? from;
  Country? to;
  String text = "";
  String result = "";
  final GoogleTranslator translator = GoogleTranslator();
  ConversationBloc()
      : super(ConversationState(
            from: ConversationFromInitial(),
            to: ConversationToInitial(),
            fromfild: ConversationFromFildInitial(),
            tofild: ConversationToFildInitial())) {
    on<ConversationEventInitial>(
      (event, emit) async {
        try {
          from = await getFromLanguage();
          if (from != null) {
            emit(
              state.copyWith(
                newfrom: ConversationFromdata(language: from!),
              ),
            );
          } else {
            emit(
              state.copyWith(
                newfrom: ConversationFromInitial(),
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              newfrom: ConversationFromError(
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
                newto: ConversationTodata(language: to!),
              ),
            );
          } else {
            emit(
              state.copyWith(
                newto: ConversationToInitial(),
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              newto: ConversationToError(
                error: e.toString(),
              ),
            ),
          );
        }
        emit(
          state.copyWith(
            newfromfild: ConversationFromFilddata(
                "", from != null ? from!.textDirection : TextDirection.ltr),
            newtofild: ConversationToFilddata(
                "", to != null ? to!.textDirection : TextDirection.ltr),
          ),
        );
      },
    );
    on<ConversationSetFrom>(
      (event, emit) async {
        from = event.language;
        if (from != null) {
          await saveFromLanguage(from!).then(
            (value) {
              if (value == true) {
                emit(
                  state.copyWith(
                    newfrom: ConversationFromdata(language: from!),
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    newfrom: const ConversationFromError(
                        error: "Something went wrong to set language"),
                  ),
                );
              }
            },
          );
        }
        text = "";
        result = "";
        emit(
          state.copyWith(
            newfromfild: ConversationFromFilddata(
                text, from != null ? from!.textDirection : TextDirection.ltr),
            newtofild: ConversationToFilddata(
                result, to != null ? to!.textDirection : TextDirection.ltr),
          ),
        );
      },
    );
    on<ConversationSetTo>(
      (event, emit) async {
        to = event.language;
        if (to != null) {
          await saveToLanguage(to!).then(
            (value) {
              if (value == true) {
                emit(state.copyWith(
                  newto: ConversationTodata(language: to!),
                ));
              } else {
                emit(
                  state.copyWith(
                    newto: const ConversationToError(
                        error: "Something went wrong to set language"),
                  ),
                );
              }
            },
          );
        }
        text = "";
        result = "";
        emit(
          state.copyWith(
            newfromfild: ConversationFromFilddata(
                text, from != null ? from!.textDirection : TextDirection.ltr),
            newtofild: ConversationToFilddata(
                result, to != null ? to!.textDirection : TextDirection.ltr),
          ),
        );
      },
    );
    on<TranslateFromIntoTo>(
      (event, emit) async {
        text = event.text;
        if (from != null && to != null && text.isNotEmpty) {
          try {
            emit(state.copyWith(
                newtofild: ConversationToFildLoading(),
                newfromfild: ConversationFromFilddata(text,
                    from != null ? from!.textDirection : TextDirection.ltr)));
            await translator
                .translate(text, from: from!.code, to: to!.code)
                .then((value) {
              result = value.text;
            });
            emit(
              state.copyWith(
                newtofild: ConversationToFilddata(
                    result, to != null ? to!.textDirection : TextDirection.ltr),
              ),
            );
          } catch (ex) {
            emit(
              state.copyWith(
                newtofild: ConversationToFildError(ex.toString()),
              ),
            );
          }
        }
      },
    );
    on<TranslateToIntoFrom>(
      (event, emit) async {
        text = event.text;
        if (from != null && to != null && text.isNotEmpty) {
          try {
            emit(
              state.copyWith(
                newtofild: ConversationToFilddata(
                    text, to != null ? to!.textDirection : TextDirection.ltr),
                newfromfild: ConversationFromFildLoading(),
              ),
            );
            await translator
                .translate(text, from: to!.code, to: from!.code)
                .then((value) {
              result = value.text;
            });
            emit(
              state.copyWith(
                newfromfild: ConversationFromFilddata(result,
                    from != null ? from!.textDirection : TextDirection.ltr),
              ),
            );
          } catch (ex) {
            emit(
              state.copyWith(
                newfromfild: ConversationFromFildError(ex.toString()),
              ),
            );
          }
        }
      },
    );
  }
  Future<bool> saveFromLanguage(Country fromLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result = await prefs.setString(
        "ConversationFrom", jsonEncode(fromLanguage.getMap));
    return result;
  }

  Future<bool> saveToLanguage(Country toLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool result =
        await prefs.setString("ConversationTo", jsonEncode(toLanguage.getMap));

    return result;
  }

  Future<Country?> getFromLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fromLanguage = prefs.getString("ConversationFrom");
    if (fromLanguage != null) {
      return Country.fromjson(jsonDecode(fromLanguage));
    } else {
      return null;
    }
  }

  Future<Country?> getToLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? toLanguage = prefs.getString("ConversationTo");
    if (toLanguage != null) {
      return Country.fromjson(jsonDecode(toLanguage));
    } else {
      return null;
    }
  }
}
