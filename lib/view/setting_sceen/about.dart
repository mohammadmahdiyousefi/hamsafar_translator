import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
            "About",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/app_icon/Google-Translate-icon.png",
                    height: 120,
                    width: 120,
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "App Version",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Gap(8),
                      FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, info) {
                            return Text(
                              info.data != null ? info.data!.version : "0.0.0",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.grey),
                            );
                          }),
                    ],
                  ),
                  const Gap(8),
                  TextButton(onPressed: () {}, child: Text("Check for updates"))
                ])));
  }
}
