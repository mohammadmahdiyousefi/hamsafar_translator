import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:translator/bloc/theme/theme_bloc.dart';
import 'package:translator/bloc/theme/theme_event.dart';
import 'package:translator/bloc/theme/theme_state.dart';
import 'package:translator/view/setting_sceen/contactus_screen.dart';

class SttingScreen extends StatelessWidget {
  const SttingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return ListTile(
                      onTap: () {
                        if (state.mode == ThemeMode.light) {
                          context.read<ThemeBloc>().add(DarkThemeEvent());
                        } else {
                          context.read<ThemeBloc>().add(LightThemeEvent());
                        }
                      },
                      leading: const Icon(Icons.dark_mode),
                      title: Text("Dark Mode",
                          style:
                              Theme.of(context).listTileTheme.titleTextStyle),
                      trailing: Switch(
                        value: state.mode == ThemeMode.dark,
                        onChanged: (value) {
                          if (value) {
                            context.read<ThemeBloc>().add(DarkThemeEvent());
                          } else {
                            context.read<ThemeBloc>().add(LightThemeEvent());
                          }
                        },
                      ),
                    );
                  },
                ),
                const Gap(16),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.bug_report),
                  title: Text("Fixed speech bug",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.share),
                  title: Text("Share",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ContactUsScreen();
                        },
                      ),
                    );
                  },
                  leading: const Icon(Icons.support_agent),
                  title: Text("Contact Us",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.balance),
                  title: Text("Terms and Conditions",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.info),
                  title: Text("About",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
