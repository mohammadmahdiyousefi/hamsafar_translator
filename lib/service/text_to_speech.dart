import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static final FlutterTts tts = FlutterTts();

  static Future<void> speek(String text, String language) async {
    await tts.stop();
    await tts.setLanguage(language).then((value) async {
      await tts.setPitch(1);
      await tts.setSpeechRate(0.3);
      await tts.setVolume(1);
      await tts.speak(text);
    });
  }

  // static Future<void> get(String text) async {
  //   var a = await tts.setLanguage('ar');
  //   print(a);
  //   var b = await tts.getLanguages;
  //   print(b);
  // }
}
