import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          AppLocalizations.of(context)!.termsandConditions,
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
              AppLocalizations.of(context)!.prarivacyPolicy,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.prarivacyPolicyText,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              AppLocalizations.of(context)!.showAds,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.showAdsText,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              AppLocalizations.of(context)!.betterPresentation,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.betterPresentationText,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              AppLocalizations.of(context)!.rightOfOwnership,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.rightOfOwnershipText,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              AppLocalizations.of(context)!.applicationPermissions,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.applicationPermissionsText,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              AppLocalizations.of(context)!.termsOfChange,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.termsOfChangeText,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey),
            ),
            const Gap(16),
            Text(
              AppLocalizations.of(context)!.bugsAndSoftwareProblems,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            Text(
              AppLocalizations.of(context)!.bugsAndSoftwareProblemsText,
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
