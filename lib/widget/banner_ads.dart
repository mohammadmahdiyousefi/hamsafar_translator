import 'package:adivery/adivery_ads.dart';

BannerAd? creatabannerad(BannerAdSize bannerAdSize) {
  BannerAd? ads = BannerAd(
    '5c14a9ec-d2c6-4e6b-9696-f47e3b1bf16c',
    bannerAdSize,
    onAdLoaded: (ad) {
      ad.loadAd();
    },
    onAdClicked: (ad) {},
    onError: (ad, reason) {},
  );
  return ads;
}
