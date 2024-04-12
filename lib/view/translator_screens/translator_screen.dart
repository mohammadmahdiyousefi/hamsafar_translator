import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/bloc/translator_screen/translate_from_state.dart';
import 'package:translator/bloc/translator_screen/translate_result_state.dart';
import 'package:translator/bloc/translator_screen/translator_bloc.dart';
import 'package:translator/bloc/translator_screen/translator_to_state.dart';
import 'package:translator/di/di.dart';
import 'package:translator/service/text_to_speech.dart';
import 'package:translator/view/translator_screens/select_from_language.dart';
import 'package:translator/view/translator_screens/select_to_language.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslatorBloc, TranslatorState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Gap(16),
                    Expanded(child: _fromLanguage(context, state.from)),
                    const Gap(12),
                    _changeLanguage(context, state.result),
                    const Gap(12),
                    Expanded(child: _toLanguage(context, state.to)),
                    const Gap(16),
                  ]),
                  const Gap(20),
                  _textFrom(context, state.from),
                  const Gap(10),
                  _textfilde(context, state.from),
                  const Gap(16),
                  _textfildcontroller(context, state.from),
                  const Gap(20),
                  _textTo(context, state.to),
                  const Gap(10),
                  _result(context, state.result),
                  const Gap(16),
                  _resultController(context, state.result, state.to),
                  const Gap(100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _fromLanguage(BuildContext context, TranslateFromState fromstate) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return BlocProvider<TranslatorBloc>.value(
                value: locator.get<TranslatorBloc>(),
                child: const SelectFromLanguage(),
              );
            },
          ));
        },
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Theme.of(context).cardColor),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: (fromstate is TranslateFromStatelanguage)
                ? Row(
                    children: [
                      Image(
                        image: AssetImage(fromstate.language.flag),
                        height: 30,
                        width: 30,
                      ),
                      const Gap(6),
                      Expanded(
                          child: Text(
                        fromstate.language.language,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const Gap(6),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).iconTheme.color,
                      )
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Select language",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const Gap(6),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
          )),
        ));
  }

  Widget _toLanguage(BuildContext context, TranslateToState tostate) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return BlocProvider<TranslatorBloc>.value(
              value: locator.get<TranslatorBloc>(),
              child: const SelectToLanguage(),
            );
          },
        ));
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).cardColor),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: (tostate is TranslateToStatelanguage)
              ? Row(
                  children: [
                    Image(
                      image: AssetImage(tostate.language.flag),
                      height: 30,
                      width: 30,
                    ),
                    const Gap(6),
                    Expanded(
                        child: Text(
                      tostate.language.language,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    )),
                    const Gap(6),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).iconTheme.color,
                    )
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Text("Select language",
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis)),
                    const Gap(6),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
        )),
      ),
    );
  }

  Widget _textFrom(BuildContext context, TranslateFromState fromstate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Translate from ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          (fromstate is TranslateFromStatelanguage)
              ? Text(
                  "(${fromstate.language.language})",
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _textfilde(BuildContext context, TranslateFromState fromstate) {
    return Container(
      height: 270,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16)),
      child: TextField(
        maxLines: 12,
        cursorColor: Theme.of(context).primaryColor,
        controller: text,
        onChanged: (value) {
          if (value.isEmpty) {
            BlocProvider.of<TranslatorBloc>(context)
                .add(TranslatorEventTranslate(text: text.text));
          }
        },
        textDirection: (fromstate is TranslateFromStatelanguage)
            ? fromstate.language.textDirection
            : TextDirection.ltr,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          hintText: 'Enter text',
          hintTextDirection: (fromstate is TranslateFromStatelanguage)
              ? fromstate.language.textDirection
              : TextDirection.ltr,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey),
          alignLabelWithHint: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(color: Colors.transparent, width: 1.8),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(color: Colors.transparent, width: 1.8),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(color: Color(0xff538DFE), width: 1.8),
          ),
        ),
      ),
    );
  }

  Widget _textfildcontroller(
      BuildContext context, TranslateFromState fromstate) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () async {
                text.text = "";
                BlocProvider.of<TranslatorBloc>(context)
                    .add(TranslatorEventTranslate(text: text.text));
                setState(() {});
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.grey,
              )),
          IconButton(
              onPressed: () async {
                if (text.text.isNotEmpty) {
                  if (fromstate is TranslateFromStatelanguage) {
                    if (fromstate.language.code == 'auto') {
                      await TextToSpeech.speek(text.text, 'en');
                    } else {
                      await TextToSpeech.speek(
                          text.text, fromstate.language.code);
                    }
                  }
                }
              },
              icon: const Icon(
                Icons.volume_up,
                color: Colors.grey,
              )),
          IconButton(
            onPressed: () {
              if (text.text.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: text.text)).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Copied to your clipboard !')));
                });
              }
            },
            icon: const Icon(
              Icons.copy,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Container(
            height: 38,
            width: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(14)),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<TranslatorBloc>(context)
                    .add(TranslatorEventTranslate(text: text.text));
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _textTo(BuildContext context, TranslateToState tostate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Translate to "),
          (tostate is TranslateToStatelanguage)
              ? Text(
                  "(${tostate.language.language})",
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _result(BuildContext context, TranslateResultState resultState) {
    return Container(
        height: 270,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16)),
        child: (resultState is TranslateResultStateLoading)
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ))
            : (resultState is TranslateResultStateSuccess)
                ? SelectableText(
                    resultState.result,
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textDirection: resultState.textDirection,
                  )
                : (resultState is TranslateResultStateEmpty)
                    ? const SizedBox()
                    : (resultState is TranslateResultStateInitial)
                        ? Text(
                            "Initialize...",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : (resultState is TranslateResultStateError)
                            ? Text(
                                resultState.error,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            : Text(
                                "Error to load data",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ));
  }

  Widget _resultController(BuildContext context,
      TranslateResultState resultState, TranslateToState tostate) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () async {
                if (resultState is TranslateResultStateSuccess) {
                  if (resultState.result.isNotEmpty) {
                    if (tostate is TranslateToStatelanguage) {
                      await TextToSpeech.speek(
                          resultState.result, tostate.language.code);
                    }
                  }
                }
              },
              icon: const Icon(
                Icons.volume_up,
                color: Colors.grey,
              )),
          IconButton(
            onPressed: () {
              if (resultState is TranslateResultStateSuccess) {
                if (resultState.result.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: resultState.result))
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Copied to your clipboard !')));
                  });
                }
              }
            },
            icon: const Icon(
              Icons.copy,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () async {
              if (resultState is TranslateResultStateSuccess) {
                if (resultState.result.isNotEmpty) {
                  await Share.share(resultState.result);
                }
              }
            },
            icon: const Icon(
              Icons.share,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _changeLanguage(
      BuildContext context, TranslateResultState resultState) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: IconButton(
        onPressed: () {
          if (resultState is TranslateResultStateSuccess) {
            if (resultState.result.isNotEmpty) {
              text.text = resultState.result;
              BlocProvider.of<TranslatorBloc>(context)
                  .add(TranslatorEventChangeLanguage());
            }
          } else {
            text.text = "";
            BlocProvider.of<TranslatorBloc>(context)
                .add(TranslatorEventChangeLanguage());
          }
        },
        icon: const Icon(
          Icons.sync,
          color: Colors.white,
        ),
      ),
    );
  }
}
