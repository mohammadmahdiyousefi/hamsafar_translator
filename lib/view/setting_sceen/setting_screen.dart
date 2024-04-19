import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/bloc/theme/theme_bloc.dart';
import 'package:translator/bloc/theme/theme_event.dart';
import 'package:translator/bloc/theme/theme_state.dart';
import 'package:translator/bloc/updateversion/updateversion_bloc.dart';
import 'package:translator/view/setting_sceen/about.dart';
import 'package:translator/view/setting_sceen/ads_screen.dart';
import 'package:translator/view/setting_sceen/app_language_screen.dart';
import 'package:translator/view/setting_sceen/contactus_screen.dart';
import 'package:translator/view/setting_sceen/pronunciation_setting.dart';
import 'package:translator/view/setting_sceen/terms_and_condition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SttingScreen extends StatelessWidget {
  const SttingScreen({super.key});
  final String shareLink =
      "https://cafebazaar.ir/app/com.example.hamsafar_translator";
  Widget customDivider(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
          const Gap(8),
          const Expanded(
              child: Divider(
            color: Colors.grey,
            endIndent: 8,
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(16),
                customDivider(
                    context, AppLocalizations.of(context)!.themeDivider),
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
                      title: Text(AppLocalizations.of(context)!.themeMode,
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
                const Gap(8),
                customDivider(
                    context, AppLocalizations.of(context)!.adsDivider),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const AdsRemoverScreen();
                        },
                      ),
                    );
                  },
                  leading: const Icon(Icons.live_tv),
                  title: Text(AppLocalizations.of(context)!.removeAds,
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(8),
                customDivider(
                    context, AppLocalizations.of(context)!.languageAppBar),
                ListTile(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const AppLanguageScreen();
                      },
                    ));
                  },
                  leading: const Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.appLanguage,
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(8),
                customDivider(context,
                    AppLocalizations.of(context)!.speechSettingDivider),
                ListTile(
                  onTap: () async {
                    await debugdiolog(context);
                  },
                  leading: const Icon(Icons.bug_report),
                  title: Text(AppLocalizations.of(context)!.fixedSpeechBug,
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
                  title: Text(
                      AppLocalizations.of(context)!.pronunciationSettings,
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
                  leading: const Icon(Icons.settings_voice),
                  title: Text(
                      AppLocalizations.of(context)!
                          .pronunciationSettingsOnTheDevice,
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(8),
                customDivider(
                    context, AppLocalizations.of(context)!.communityDivider),
                ListTile(
                  onTap: () async {
                    await Share.shareUri(Uri.parse(shareLink));
                  },
                  leading: const Icon(Icons.share),
                  title: Text(AppLocalizations.of(context)!.share,
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
                  title: Text(AppLocalizations.of(context)!.contactUs,
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(8),
                customDivider(
                    context, AppLocalizations.of(context)!.helpDivider),
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
                  title: Text(AppLocalizations.of(context)!.termsandConditions,
                      style: Theme.of(context).listTileTheme.titleTextStyle),
                ),
                const Gap(16),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => UpdateversionBloc(),
                            child: AboutScreen(),
                          );
                        },
                      ),
                    );
                  },
                  leading: const Icon(Icons.info),
                  title: Text(AppLocalizations.of(context)!.about,
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
        "https://play.google.com/store/apps/details?id=com.google.android.tts";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.fixedSpeechDiolog,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          content: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.cancelButton),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  await canLaunchUrl(Uri.parse(googlelink)).then((value) async {
                    if (value) {
                      await launchUrl(
                        Uri.parse(googlelink),
                      );
                    } else {
                      await launchUrl(Uri.parse(googlelink),
                          mode: LaunchMode.externalApplication);
                    }
                  });
                },
                child:
                    Text(AppLocalizations.of(context)!.fixedSpeechUpdateButton),
              ),
            ],
          ),
        );
      },
    );
  }
}
