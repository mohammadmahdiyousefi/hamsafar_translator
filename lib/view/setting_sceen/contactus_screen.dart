import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  final String email = "mailto:mmye1481@gmail.com";
  final String telegram = "https://t.me/translator_app";
  final String github = "https://github.com/translator-app";
  Future<void> _launchUrl(String url) async {
    bool isInstalled = await canLaunchUrl(Uri.parse(url));
    if (isInstalled == false) {
      await launchUrl(Uri.parse(url));
    }
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
          "Contact Us",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(16),
            ListTile(
              onTap: () async {
                await _launchUrl(email);
              },
              leading: const Icon(Icons.email),
              title: Text("E-mail",
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
              title: Text("Telegram",
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
              leading: const Icon(Icons.hub),
              title: Text("GitHub",
                  style: Theme.of(context).listTileTheme.titleTextStyle),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
