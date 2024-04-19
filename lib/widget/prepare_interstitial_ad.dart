import 'package:adivery/adivery.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showInterstitial() {
  AdiveryPlugin.isLoaded('37514faa-b896-40d2-9c67-a3a0308eb947')
      .then((isLoaded) async {
    if (isLoaded == true && isLoaded != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if ((prefs.getInt("ads") ?? 0) < 20) {
        showPlacement(isLoaded, '37514faa-b896-40d2-9c67-a3a0308eb947');
      }
    }
  });
}

void showPlacement(bool isLoaded, String placementId) {
  if (isLoaded) {
    AdiveryPlugin.show(placementId);
  }
}
