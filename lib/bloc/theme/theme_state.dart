import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final String appLanguage;
  const ThemeState({required this.mode, required this.appLanguage});
  @override
  List<Object> get props => [mode, appLanguage];
  ThemeState copyWith({String? selectedLanguage, ThemeMode? newmode}) {
    return ThemeState(
        mode: newmode ?? mode, appLanguage: selectedLanguage ?? appLanguage);
  }
}

// class InitialThemeState extends ThemeState {
//   const InitialThemeState(super.mode, {super.appLanguage = 'en'});
//   @override
//   List<Object> get props => [mode];
// }

// class LightThemeState extends ThemeState {
//   const LightThemeState(super.mode);
//   @override
//   List<Object> get props => [mode];
// }

// class DarkThemeState extends ThemeState {
//   const DarkThemeState(super.mode);
//   @override
//   List<Object> get props => [mode];
// }

// class SystemThemeModeState extends ThemeState {
//   const SystemThemeModeState(super.mode);
//   @override
//   List<Object> get props => [mode];
// }

// class Cangelanguage extends ThemeState {
//   const Cangelanguage(super.mode, {super.appLanguage});
//   @override
//   List<Object> get props => [mode];
// }
