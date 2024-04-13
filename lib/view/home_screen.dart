import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:translator/bloc/translator_screen/translator_bloc.dart';
import 'package:translator/di/di.dart';
import 'package:translator/view/setting_sceen/setting_screen.dart';
import 'package:translator/view/translator_screens/translator_screen.dart';
import 'package:translator/view/conversation_screen/conversation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  void initState() {
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
            setState(() {
              index = value;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.translate,
                  color: Colors.white70,
                  size: 20,
                ),
                selectedIcon: Icon(
                  Icons.translate,
                  color: Colors.white,
                  size: 20,
                ),
                label: "Translate"),
            NavigationDestination(
                icon: Icon(
                  Icons.record_voice_over,
                  color: Colors.white70,
                  size: 20,
                ),
                selectedIcon: Icon(
                  Icons.record_voice_over,
                  color: Colors.white,
                  size: 20,
                ),
                label: "Conversation"),
            NavigationDestination(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white70,
                  size: 20,
                ),
                selectedIcon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
                label: "Setting")
          ],
        ),
      ),
    );
  }
}
