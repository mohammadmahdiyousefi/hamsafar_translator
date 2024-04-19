import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:translator/widget/banner_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  final String email = "mailto:mmye1481@gmail.com";
  final String telegram = "https://t.me/Hamsafar_Translatorbot";
  final String github =
      "https://github.com/mohammadmahdiyousefi/translator/tags";
  Future<void> _launchUrl(String url) async {
    await canLaunchUrl(Uri.parse(url)).then((value) async {
      if (value) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color),
        ),
        title: Text(
          AppLocalizations.of(context)!.contactUs,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              ListTile(
                onTap: () async {
                  await _launchUrl(email);
                },
                leading: const Icon(Icons.email),
                title: Text(AppLocalizations.of(context)!.emailText,
                    style: Theme.of(context).listTileTheme.titleTextStyle),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Gap(16),
              ListTile(
                onTap: () async {
                  await _launchUrl(telegram);
                },
                leading: const Icon(Icons.near_me),
                title: Text(AppLocalizations.of(context)!.telegramText,
                    style: Theme.of(context).listTileTheme.titleTextStyle),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Gap(16),
              ListTile(
                onTap: () async {
                  await _launchUrl(github);
                },
                leading: const Icon(Icons.g_mobiledata),
                title: Text(AppLocalizations.of(context)!.githubText,
                    style: Theme.of(context).listTileTheme.titleTextStyle),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const Gap(32),
              creatabannerad(BannerAdSize.MEDIUM_RECTANGLE) ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
