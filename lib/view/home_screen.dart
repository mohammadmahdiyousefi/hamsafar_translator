import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adivery/adivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:translator/bloc/translator_screen/translator_bloc.dart';
import 'package:translator/di/di.dart';
import 'package:translator/view/setting_sceen/setting_screen.dart';
import 'package:translator/view/translator_screens/translator_screen.dart';
import 'package:translator/view/conversation_screen/conversation_screen.dart';
import 'package:translator/widget/prepare_interstitial_ad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Timer? adstimer;
  @override
  void initState() {
    AdiveryPlugin.prepareInterstitialAd('37514faa-b896-40d2-9c67-a3a0308eb947');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _bottomNavigationBar(),
        body: IndexedStack(index: index, children: [
          BlocProvider(
            create: (context) {
              var bloc = locator.get<TranslatorBloc>();
              bloc.add(TranslatorEventInitial());
              return bloc;
            },
            child: const TranslatorScreen(),
          ),
          BlocProvider(
            create: (context) {
              var bloc = locator.get<ConversationBloc>();
              bloc.add(ConversationEventInitial());
              return bloc;
            },
            child: const VoiceScreen(),
          ),
          const SttingScreen()
        ]));
  }

  Widget _bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            if (adstimer != null) {
              adstimer!.cancel();
            }

            adstimer = Timer.periodic(const Duration(seconds: 5), (timer) {
              showInterstitial();
              adstimer!.cancel();
            });
            setState(() {
              index = value;
            });
          },
          destinations: [
            NavigationDestination(
                icon: const Icon(
                  Icons.translate,
                  color: Colors.white70,
                  size: 20,
                ),
                selectedIcon: const Icon(
                  Icons.translate,
                  color: Colors.white,
                  size: 20,
                ),
                label: AppLocalizations.of(context)!.translateNavbar),
            NavigationDestination(
                icon: const Icon(
                  Icons.record_voice_over,
                  color: Colors.white70,
                  size: 20,
                ),
                selectedIcon: const Icon(
                  Icons.record_voice_over,
                  color: Colors.white,
                  size: 20,
                ),
                label: AppLocalizations.of(context)!.conversationNavbar),
            NavigationDestination(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white70,
                  size: 20,
                ),
                selectedIcon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
                label: AppLocalizations.of(context)!.settingNavbar)
          ],
        ),
      ),
    );
  }
}
