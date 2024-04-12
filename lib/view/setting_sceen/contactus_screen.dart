import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ContactUsScreen();
                    },
                  ),
                );
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ContactUsScreen();
                    },
                  ),
                );
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
