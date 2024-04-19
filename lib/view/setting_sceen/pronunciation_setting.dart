import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:translator/service/text_to_speech.dart';
import 'package:translator/widget/banner_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PronuncaitionScreen extends StatelessWidget {
  const PronuncaitionScreen({super.key});

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
          AppLocalizations.of(context)!.pronunciationAppBarTitle,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              const PitchControllerWidget(),
              const Gap(8),
              const SpeechRateControllerWidget(),
              const Gap(8),
              const VolumeControllerWidget(),
              const Gap(8),
              Row(
                children: [
                  const Gap(8),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Theme.of(context).cardColor),
                          onPressed: () {
                            TextToSpeech.speek(
                                "this is an example of speech synthesis in english",
                                "en");
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .pronunciationPlayButton,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ))),
                  const Gap(16),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Theme.of(context).cardColor),
                          onPressed: () async {
                            await TextToSpeech.setPitch(1);
                            await TextToSpeech.setSpeechRate(0.3);
                            await TextToSpeech.setVolume(1);
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .pronunciationResetButton,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ))),
                  const Gap(8),
                ],
              ),
              const Gap(32),
              creatabannerad(BannerAdSize.MEDIUM_RECTANGLE) ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class PitchControllerWidget extends StatefulWidget {
  const PitchControllerWidget({super.key});

  @override
  State<PitchControllerWidget> createState() => _PitchControllerWidgetState();
}

class _PitchControllerWidgetState extends State<PitchControllerWidget> {
  double pitch = 0.5;
  @override
  void initState() {
    TextToSpeech.getPitch().then((value) {
      pitch = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.pronunciationPitch,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                pitch.toStringAsFixed(2),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Slider(
          min: 0.5,
          max: 2,
          value: pitch,
          onChangeEnd: (value) async {
            await TextToSpeech.setPitch(value).then(
              (value) {
                setState(
                  () {
                    pitch = value;
                  },
                );
              },
            );
          },
          onChanged: (value) async {
            setState(
              () {
                pitch = value;
              },
            );
          },
        ),
      ],
    );
  }
}

class SpeechRateControllerWidget extends StatefulWidget {
  const SpeechRateControllerWidget({super.key});

  @override
  State<SpeechRateControllerWidget> createState() =>
      _SpeechRateControllerWidgetState();
}

class _SpeechRateControllerWidgetState
    extends State<SpeechRateControllerWidget> {
  double speechrate = 0.3;
  @override
  void initState() {
    TextToSpeech.getSpeechRate().then((value) {
      speechrate = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.pronunciationSpeechRate,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                (speechrate * 100).round().toString(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Slider(
          min: 0.0,
          max: 1,
          value: speechrate,
          onChangeEnd: (value) async {
            await TextToSpeech.setSpeechRate(value).then(
              (value) {
                setState(
                  () {
                    speechrate = value;
                  },
                );
              },
            );
          },
          onChanged: (value) async {
            setState(
              () {
                speechrate = value;
              },
            );
          },
        ),
      ],
    );
  }
}

class VolumeControllerWidget extends StatefulWidget {
  const VolumeControllerWidget({super.key});

  @override
  State<VolumeControllerWidget> createState() => _VolumeControllerWidgetState();
}

class _VolumeControllerWidgetState extends State<VolumeControllerWidget> {
  double volume = 1;
  @override
  void initState() {
    TextToSpeech.getVolume().then((value) {
      volume = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.pronunciationVolume,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                (volume * 100).round().toString(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Slider(
          min: 0.0,
          max: 1,
          value: volume,
          onChangeEnd: (value) async {
            await TextToSpeech.setVolume(value).then(
              (value) {
                setState(
                  () {
                    volume = value;
                  },
                );
              },
            );
          },
          onChanged: (value) async {
            setState(
              () {
                volume = value;
              },
            );
          },
        ),
      ],
    );
  }
}
