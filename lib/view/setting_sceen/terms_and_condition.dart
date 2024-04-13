import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

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
          "Terms & Conditions",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            Text(
              "Prarivacy Policy",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """Your privacy is valuable to us, and to clarify this privacy, especially between us and users, the conditions of using the application (advertisements, privacy, access, etc.) are explained.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Show ads",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """The program is completely free, but in order to cover the production and development costs of the software, advertisements are used in the program, which are used to load a small amount of the user's internet.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Better presentation of your service",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """The purpose of collecting information is to provide better services to users. According to these data, it is not possible to match the user's person and the data without the user's request and providing more information. And in fact, this category of information has nothing to do with your personal and individual information. Through the program, this information is sent by the user to the data and statistics servers, such as: model, brand, Android version, information related to device events such as crash and Other parameters used in the program.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Right of ownership",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """All texts, images and other works in the content of the program are copyrighted and the user has no right to use them without obtaining permission.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Application permissions",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """This app does not require any dangerous permissions.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Terms of change",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """The text of this agreement may change in the future. The program owner reserves the right to change these conditions at any time without giving reasons. We are not obliged to inform the user about this and it is the responsibility of the user to read these conditions again.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Terms of change",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """The text of this agreement may change in the future. The program owner reserves the right to change these conditions at any time without giving reasons. We are not obliged to inform the user about this and it is the responsibility of the user to read these conditions again.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "Bugs and software problems",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              """We always seek to solve problems and improve the software, but due to the spread of devices and different versions of Android, the performance of the software may be buggy on some devices or versions, and we apologize for this.""",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              "GooglePlay Services",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
            ),
            const Gap(16),
            Text(
              "Admob Ads",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
            ),
            const Gap(16),
            Text(
              "Privacy Policy",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
            ),
            const Gap(16),
          ],
        ),
      )),
    );
  }
}
