import 'package:adivery/adivery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/service/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdsRemoverScreen extends StatefulWidget {
  const AdsRemoverScreen({super.key});

  @override
  State<AdsRemoverScreen> createState() => _AdsRemoverScreenState();
}

class _AdsRemoverScreenState extends State<AdsRemoverScreen> {
  final String revardplacementId = "318e0352-254a-49b3-9108-8c70c99eff55";
  bool isclicked = false;
  int numberOfClicks = 0;
  void showRewarded() {
    AdiveryPlugin.isLoaded(revardplacementId).then((isLoaded) {
      if (isLoaded == false && isLoaded != null) {
        ToastMessage.showCustomToast(
            context, AppLocalizations.of(context)!.noAds, Colors.red);
      } else if (isLoaded == true && isLoaded != null) {
        showPlacement(isLoaded, revardplacementId);
      } else {}
    });
  }

  void showPlacement(bool isLoaded, String placementId) {
    if (isLoaded) {
      AdiveryPlugin.show(placementId);
    }
  }

  void adListener() {
    AdiveryPlugin.addListener(
      onRewardedLoaded: onRewardedLoaded,
      onRewardedClosed: onRewardedClosed,
      onRewardedClicked: onRewardedClicked,
      onError: onError,
    );
  }

  void onRewardedLoaded(String placementId) {
    ToastMessage.showCustomToast(
        context, AppLocalizations.of(context)!.adsAvailable, Colors.green);
    if (kDebugMode) {
      print("rewarded ad loaded");
    }
  }

  void onRewardedClosed(String placement, bool isRewarded) {
    if (isclicked == true && isRewarded == true) {
      saveClicked();
      ToastMessage.showCustomToast(
          context, AppLocalizations.of(context)!.succssesShowAd, Colors.green);
    } else {
      ToastMessage.showCustomToast(
          context, AppLocalizations.of(context)!.errorViewingTheAd, Colors.red);
    }
    if (kDebugMode) {
      print("onRewardedClosed");
    }
  }

  void onRewardedClicked(String placement) {
    isclicked = true;
    if (kDebugMode) {
      print("onRewardedClicked");
    }
  }

  void onError(String placement, String error) {
    if (kDebugMode) {
      print("onRewardedClicked");
    }
  }

  void saveClicked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int numberAds = prefs.getInt("ads") ?? 0;
    numberAds = numberAds + 1;
    await prefs.setInt("ads", numberAds).then((value) {
      if (value) {
        numberOfClicks = prefs.getInt("ads") ?? 0;
        setState(() {});
      }
    });
  }

  Future<int> getClicked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("ads") ?? 0;
  }

  @override
  void initState() {
    AdiveryPlugin.prepareRewardedAd(revardplacementId);
    adListener();
    getClicked().then((value) {
      numberOfClicks = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AppLocalizations.of(context)!.adsAppbartext,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Text(
                AppLocalizations.of(context)!.adsText1,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(16),
              Text(
                AppLocalizations.of(context)!.adsText2,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              const Gap(16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(100, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Theme.of(context).cardColor),
                  onPressed: () async {
                    isclicked = false;
                    showRewarded();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.live_tv,
                        color: Color(0xFFAA0B00),
                      ),
                      const Gap(8),
                      Text(
                        AppLocalizations.of(context)!.adsShowButton,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xFFAA0B00)),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(32),
              Text(
                  "${AppLocalizations.of(context)!.numberOfAdsViewed} ${numberOfClicks.toString()}",
                  style: Theme.of(context).textTheme.bodyLarge),
              const Gap(32),
              Text(AppLocalizations.of(context)!.advertisingTerms,
                  style: Theme.of(context).textTheme.bodyMedium),
              const Gap(16),
              Text(
                AppLocalizations.of(context)!.terms1,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              const Gap(16),
              Text(
                AppLocalizations.of(context)!.terms2,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              const Gap(16),
              Text(
                AppLocalizations.of(context)!.terms3,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              const Gap(16),
              Text(
                AppLocalizations.of(context)!.terms4,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
