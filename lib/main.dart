import 'package:adivery/adivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translator/bloc/theme/theme_bloc.dart';
import 'package:translator/bloc/theme/theme_event.dart';
import 'package:translator/bloc/theme/theme_state.dart';
import 'package:translator/di/di.dart';
import 'package:translator/view/home_screen.dart';
import 'package:translator/model/theme_class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AdiveryPlugin.initialize('8af1994c-a3e5-4e70-bcb0-c7c2867882b7');
  getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var themeBloc = ThemeBloc();
        themeBloc.add(InitThemeEvent());
        return themeBloc;
      },
      child: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeAnimationDuration: Duration.zero,
            themeMode: state.mode,
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkThem,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            locale: Locale(state.appLanguage),
            supportedLocales: const [
              Locale("fa"),
              Locale("en"),
            ],
            home: const HomeScreen());
      },
    );
  }
}
