import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(const ThemeState(appLanguage: 'en', mode: ThemeMode.light)) {
    on<InitThemeEvent>((event, emit) async {
      await getTheme().then((value) async {
        if (value) {
          emit(state.copyWith(newmode: ThemeMode.dark));
        } else {
          emit(state.copyWith(newmode: ThemeMode.light));
        }
        await getLanguage().then((value) {
          emit(state.copyWith(selectedLanguage: value));
        });
      });
    });
    on<LightThemeEvent>((event, emit) async {
      await setTheme(false).then((value) {
        if (value) {
          emit(state.copyWith(newmode: ThemeMode.light));
        } else {
          emit(state.copyWith(newmode: ThemeMode.dark));
        }
      });
    });
    on<DarkThemeEvent>((event, emit) async {
      await setTheme(true).then((value) {
        if (value) {
          emit(state.copyWith(newmode: ThemeMode.dark));
        } else {
          emit(state.copyWith(newmode: ThemeMode.light));
        }
      });
    });
    on<SystemThemeModeEvent>((event, emit) async {});
    on<SetLanguage>((event, emit) async {
      await setLanguage(event.language).then(
        (value) {
          if (value) {
            emit(state.copyWith(selectedLanguage: event.language));
          }
        },
      );
    });
  }
  Future<bool> setTheme(bool isdark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool settheme = await prefs.setBool("Theme", isdark);
    return settheme;
  }

  Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool settheme = prefs.getBool("Theme") ?? false;
    return settheme;
  }

  Future<bool> setLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool setLanguage = await prefs.setString("Language", language);
    return setLanguage;
  }

  Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String setLanguage = prefs.getString("Language") ?? "en";
    return setLanguage;
  }
}
