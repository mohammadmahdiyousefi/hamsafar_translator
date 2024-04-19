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
  Country from = Country(
    name: 'Iran',
    language: 'Persian',
    flag: 'assets/images/flag/ir.png',
    code: 'fa',
    textDirection: TextDirection.rtl,
  );
  Country to = Country(
    name: 'United States',
    language: 'English',
    flag: 'assets/images/flag/us.png',
    code: 'en',
    textDirection: TextDirection.ltr,
  );
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
          await getFromLanguage().then(
            (value) async {
              if (value != null) {
                from = value;
                emit(
                  state.copyWith(
                    newfrom: ConversationFromdata(language: from),
                  ),
                );
              } else {
                await saveFromLanguage(from).then(
                  (value) {
                    if (value) {
                      emit(
                        state.copyWith(
                          newfrom: ConversationFromdata(language: from),
                        ),
                      );
                    } else {
                      emit(
                        state.copyWith(
                          newfrom: ConversationFromInitial(),
                        ),
                      );
                    }
                  },
                );
              }
            },
          );
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
          await getToLanguage().then(
            (value) async {
              if (value != null) {
                to = value;
                emit(
                  state.copyWith(
                    newto: ConversationTodata(language: to),
                  ),
                );
              } else {
                await saveToLanguage(to).then(
                  (value) {
                    if (value) {
                      emit(
                        state.copyWith(
                          newto: ConversationTodata(language: to),
                        ),
                      );
                    } else {
                      emit(
                        state.copyWith(
                          newto: ConversationToInitial(),
                        ),
                      );
                    }
                  },
                );
              }
            },
          );
        } catch (e) {
          emit(
            state.copyWith(
              newto: ConversationToError(
                error: e.toString(),
              ),
            ),
          );
        }
        try {
          await translator
              .translate("Tap on the microphone to chat",
                  from: "en", to: from.code)
              .then((value) {
            text = value.text;
            emit(
              state.copyWith(
                newfromfild: ConversationFromFilddata(text, from.textDirection),
                newtofild: ConversationToFilddata(result, to.textDirection),
              ),
            );
          });
        } catch (e) {
          emit(
            state.copyWith(
              newfromfild: ConversationFromFilddata("", from.textDirection),
            ),
          );
        }
        try {
          await translator
              .translate("Tap on the microphone to chat",
                  from: "en", to: to.code)
              .then((value) {
            result = value.text;
            emit(
              state.copyWith(
                newtofild: ConversationToFilddata(result, to.textDirection),
              ),
            );
          });
        } catch (e) {
          emit(
            state.copyWith(
              newtofild: ConversationToFilddata("", to.textDirection),
            ),
          );
        }
      },
    );
    on<ConversationSetFrom>(
      (event, emit) async {
        from = event.language;
        await saveFromLanguage(from).then(
          (value) {
            if (value == true) {
              emit(
                state.copyWith(
                  newfrom: ConversationFromdata(language: from),
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

        text = "";
        result = "";
        emit(
          state.copyWith(
            newfromfild: ConversationFromFilddata(text, from.textDirection),
            newtofild: ConversationToFilddata(result, to.textDirection),
          ),
        );
      },
    );
    on<ConversationSetTo>(
      (event, emit) async {
        to = event.language;

        await saveToLanguage(to).then(
          (value) {
            if (value == true) {
              emit(state.copyWith(
                newto: ConversationTodata(language: to),
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

        text = "";
        result = "";
        emit(
          state.copyWith(
            newfromfild: ConversationFromFilddata(text, from.textDirection),
            newtofild: ConversationToFilddata(result, to.textDirection),
          ),
        );
      },
    );
    on<TranslateFromIntoTo>(
      (event, emit) async {
        text = event.text;
        if (text.isNotEmpty) {
          try {
            emit(state.copyWith(
                newtofild: ConversationToFildLoading(),
                newfromfild:
                    ConversationFromFilddata(text, from.textDirection)));
            await translator
                .translate(text, from: from.code, to: to.code)
                .then((value) {
              result = value.text;
            });
            emit(
              state.copyWith(
                newtofild: ConversationToFilddata(result, to.textDirection),
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
        if (text.isNotEmpty) {
          try {
            emit(
              state.copyWith(
                newtofild: ConversationToFilddata(text, to.textDirection),
                newfromfild: ConversationFromFildLoading(),
              ),
            );
            await translator
                .translate(text, from: to.code, to: from.code)
                .then((value) {
              result = value.text;
            });
            emit(
              state.copyWith(
                newfromfild:
                    ConversationFromFilddata(result, from.textDirection),
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
