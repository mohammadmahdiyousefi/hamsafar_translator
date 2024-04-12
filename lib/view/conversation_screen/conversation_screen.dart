import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:translator/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:translator/bloc/conversation_bloc/conversation_from.dart';
import 'package:translator/bloc/conversation_bloc/conversation_from_fild.dart';
import 'package:translator/bloc/conversation_bloc/conversation_to.dart';
import 'package:translator/bloc/conversation_bloc/conversation_to_fild.dart';
import 'package:translator/di/di.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';
import 'package:translator/service/text_to_speech.dart';
import 'package:translator/service/toast.dart';
import 'package:translator/view/conversation_screen/conversation_from_language.dart';
import 'package:translator/view/conversation_screen/conversation_to_language.dart';

class VoiceScreen extends StatelessWidget {
  const VoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: _conversationFromFild(
                      context, state.fromfild, state.from),
                ),
                Expanded(
                  child: _conversationToFild(context, state.tofild, state.to),
                ),
                const Gap(8),
                Row(
                  children: [
                    const Gap(16),
                    Expanded(child: _toLanguage(context, state.to)),
                    const Gap(32),
                    Expanded(child: _fromLanguage(context, state.from)),
                    const Gap(16),
                  ],
                ),
                const Gap(16),
                Row(
                  children: [
                    Expanded(child: _toVoiceButton(context, state.to)),
                    Expanded(child: _fromVoiceButton(context, state.from))
                  ],
                ),
                const Gap(85),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _conversationFromFild(
    BuildContext context,
    ConversationFromFildState state,
    ConversationFromState fromState,
  ) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor),
        child: Column(
          children: [
            fromState is ConversationFromInitial
                ? SizedBox(
                    child: Text(
                      "Select language",
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : fromState is ConversationFromdata
                    ? Row(
                        children: [
                          Image(
                            image: AssetImage(fromState.language.flag),
                            height: 30,
                            width: 30,
                          ),
                          const Gap(6),
                          Expanded(
                            child: Text(
                              fromState.language.language,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (state is ConversationFromFilddata) {
                                if (state.data.isNotEmpty) {
                                  await TextToSpeech.speek(
                                      state.data, fromState.language.code);
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.volume_up,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : fromState is ConversationFromError
                        ? Row(
                            children: [
                              Expanded(
                                child: Text(
                                  fromState.error,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
            const Divider(
              height: 3,
            ),
            Expanded(
                child: state is ConversationFromFildInitial
                    ? const SizedBox()
                    : state is ConversationFromFildLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : state is ConversationFromFilddata
                            ? Center(
                                child: SingleChildScrollView(
                                  child: Text(
                                    state.data,
                                    textAlign: TextAlign.center,
                                    textDirection: state.direction,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              )
                            : state is ConversationFromFildError
                                ? Center(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        state.error,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : const SizedBox()),
          ],
        ));
  }

  Widget _conversationToFild(
    BuildContext context,
    ConversationToFildState state,
    ConversationToState toState,
  ) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor),
        child: Column(
          children: [
            toState is ConversationToInitial
                ? SizedBox(
                    child: Text(
                      "Select language",
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : toState is ConversationTodata
                    ? Row(
                        children: [
                          Image(
                            image: AssetImage(toState.language.flag),
                            height: 30,
                            width: 30,
                          ),
                          const Gap(6),
                          Expanded(
                            child: Text(
                              toState.language.language,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (state is ConversationToFilddata) {
                                if (state.data.isNotEmpty) {
                                  await TextToSpeech.speek(
                                      state.data, toState.language.code);
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.volume_up,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : toState is ConversationToError
                        ? Row(
                            children: [
                              Expanded(
                                  child: Text(
                                toState.error,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ],
                          )
                        : const SizedBox(),
            const Divider(
              height: 3,
            ),
            Expanded(
                child: state is ConversationToFildInitial
                    ? const SizedBox()
                    : state is ConversationToFildLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : state is ConversationToFilddata
                            ? Center(
                                child: SingleChildScrollView(
                                  child: Text(
                                    state.data,
                                    textDirection: state.direction,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              )
                            : state is ConversationToFildError
                                ? Center(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        state.error,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                : const SizedBox()),
          ],
        ));
  }

  Widget _fromLanguage(
    BuildContext context,
    ConversationFromState fromState,
  ) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return BlocProvider<ConversationBloc>.value(
                  value: locator.get<ConversationBloc>(),
                  child: const ConversationFromLanguage());
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
            child: (fromState is ConversationFromdata)
                ? Row(
                    children: [
                      Image(
                        image: AssetImage(fromState.language.flag),
                        height: 30,
                        width: 30,
                      ),
                      const Gap(6),
                      Expanded(
                          child: Text(
                        fromState.language.language,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const Gap(6),
                      const Icon(Icons.keyboard_arrow_down)
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

  Widget _toLanguage(BuildContext context, ConversationToState toState) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return BlocProvider<ConversationBloc>.value(
                value: locator.get<ConversationBloc>(),
                child: const ConversationToLanguage(),
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
            child: (toState is ConversationTodata)
                ? Row(
                    children: [
                      Image(
                        image: AssetImage(toState.language.flag),
                        height: 30,
                        width: 30,
                      ),
                      const Gap(6),
                      Expanded(
                          child: Text(
                        toState.language.language,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      )),
                      const Gap(6),
                      const Icon(Icons.keyboard_arrow_down)
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

  Widget _toVoiceButton(BuildContext context, ConversationToState toState) {
    return CircleAvatar(
      backgroundColor: Colors.red,
      radius: 30,
      child: GestureDetector(
        onTap: () async {
          if (toState is ConversationTodata) {
            await SpeechToTextGoogleDialog.getInstance()
                .showGoogleDialog(
                    onTextReceived: (data) {
                      BlocProvider.of<ConversationBloc>(context)
                          .add(TranslateToIntoFrom(data));
                    },
                    locale: toState.language.code)
                .then((value) {
              if (!value) {
                ToastMessage.showCustomToast(context,
                    "Service is not available", const Color(0xFF373737));
              }
            });
          } else {
            ToastMessage.showCustomToast(
                context, "Please select language", const Color(0xFF373737));
          }
        },
        child: const Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _fromVoiceButton(
      BuildContext context, ConversationFromState fromState) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 30,
      child: GestureDetector(
        onTap: () async {
          if (fromState is ConversationFromdata) {
            await SpeechToTextGoogleDialog.getInstance()
                .showGoogleDialog(
                    onTextReceived: (data) {
                      BlocProvider.of<ConversationBloc>(context)
                          .add(TranslateFromIntoTo(data));
                    },
                    locale: fromState.language.code)
                .then((value) {
              if (!value) {
                ToastMessage.showCustomToast(context,
                    "Service is not available", const Color(0xFF373737));
              }
            });
          } else {
            ToastMessage.showCustomToast(
                context, "Please select language", const Color(0xFF373737));
          }
        },
        child: const Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
