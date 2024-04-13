import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:translator/bloc/theme/theme_bloc.dart';
import 'package:translator/bloc/theme/theme_event.dart';
import 'package:translator/bloc/theme/theme_state.dart';
import 'package:translator/view/setting_sceen/about.dart';
import 'package:translator/view/setting_sceen/contactus_screen.dart';
import 'package:translator/view/setting_sceen/pronunciation_setting.dart';
import 'package:translator/view/setting_sceen/terms_and_condition.dart';
import 'package:url_launcher/url_launcher.dart';

class SttingScreen extends StatelessWidget {
  const SttingScreen({super.key});
  Widget customDivider(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const Gap(8),
          const Expanded(child: Divider())
        ],
      ),
    );
  }

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
                const Gap(16),
                customDivider(context, "Theme"),
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
                customDivider(context, "Speech Settings"),
                ListTile(
                  onTap: () async {
                    await debugdiolog(context);
                  },
                  leading: const Icon(Icons.bug_report),
                  title: Text("Fixed speech bug",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const PronuncaitionScreen();
                      },
                    ));
                  },
                  leading: const Icon(Icons.record_voice_over),
                  title: Text("pronunciation settings",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () async {
                    AndroidIntent intent = const AndroidIntent(
                      action: 'com.android.settings.TTS_SETTINGS',
                    );
                    await intent.launch();
                  },
                  leading: const Icon(Icons.settings_accessibility),
                  title: Text("pronunciation settings on the device",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                customDivider(context, "Community"),
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
                customDivider(context, "Help"),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const TermsAndConditionScreen();
                        },
                      ),
                    );
                  },
                  leading: const Icon(Icons.balance),
                  title: Text("Terms & Conditions",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const AboutScreen();
                        },
                      ),
                    );
                  },
                  leading: const Icon(Icons.info),
                  title: Text("About",
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(75)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future debugdiolog(BuildContext context) async {
    const String googlelink =
        "https://play.google.com/store/apps/details?id=com.google.android.tts&pcampaignid=web_share";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "If the pronunciation or speech recognition section does not work for you, it may be because Google services are not installed or updated, install and update the speech recognition service as soon as possible.",
            style: Theme.of(context).textTheme.titleSmall,
            textDirection: TextDirection.ltr,
          ),
          content: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  bool isInstalled = await canLaunchUrl(Uri.parse(googlelink));
                  if (isInstalled == false) {
                    await launchUrl(Uri.parse(googlelink));
                  }
                },
                child: const Text("Update & Install"),
              ),
            ],
          ),
        );
      },
    );
  }
}
