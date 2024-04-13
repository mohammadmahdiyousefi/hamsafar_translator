import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextToSpeech {
  static final FlutterTts tts = FlutterTts();

  static Future<void> speek(String text, String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await tts.stop();
    await tts.setLanguage(language).then((value) async {
      await tts.setPitch(prefs.getDouble("pitch") ?? 1);
      await tts.setSpeechRate(prefs.getDouble("speechRate") ?? 0.3);
      await tts.setVolume(prefs.getDouble("Volume") ?? 1);
      await tts.speak(text);
    });
  }

  static Future<double> setPitch(double pitch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("pitch", pitch).then(
          (value) async => await tts.setPitch(pitch),
        );
    return prefs.getDouble("pitch") ?? 1;
  }

  static Future<double> getPitch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("pitch") ?? 1;
  }

  static Future<double> setSpeechRate(double speechRate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("speechRate", speechRate).then(
          (value) async => await tts.setSpeechRate(speechRate),
        );
    return prefs.getDouble("speechRate") ?? 0.3;
  }

  static Future<double> getSpeechRate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("speechRate") ?? 0.3;
  }

  static Future<double> setVolume(double volume) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("Volume", volume).then(
          (value) async => await tts.setVolume(volume),
        );
    return prefs.getDouble("Volume") ?? 1;
  }

  static Future<double> getVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("Volume") ?? 1;
  }
}
