import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:translator/bloc/theme/theme_bloc.dart';
import 'package:translator/bloc/theme/theme_event.dart';
import 'package:translator/bloc/theme/theme_state.dart';

class AppLanguageScreen extends StatelessWidget {
  const AppLanguageScreen({super.key});

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
          AppLocalizations.of(context)!.appLanguage,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(SetLanguage("fa"));
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.41,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).listTileTheme.tileColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: state.appLanguage == "fa"
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              width: 2)),
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage("assets/images/flag/ir.png"),
                            height: 50,
                            width: 50,
                          ),
                          const Gap(8),
                          Expanded(
                            child: Text(
                              "Persion (Iran)",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .listTileTheme
                                  .titleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(SetLanguage("en"));
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.41,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).listTileTheme.tileColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: state.appLanguage == "en"
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              width: 2)),
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage("assets/images/flag/us.png"),
                            height: 50,
                            width: 50,
                          ),
                          const Gap(8),
                          Expanded(
                            child: Text(
                              "America (Us)",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .listTileTheme
                                  .titleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     BlocProvider.of<ThemeBloc>(context)
                  //         .add(SetLanguage("ar"));
                  //   },
                  //   child: Container(
                  //     height: 120,
                  //     width: MediaQuery.of(context).size.width * 0.41,
                  //     margin: const EdgeInsets.symmetric(
                  //         horizontal: 8, vertical: 8),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 16),
                  //     decoration: BoxDecoration(
                  //         color: Theme.of(context).listTileTheme.tileColor,
                  //         borderRadius: BorderRadius.circular(14),
                  //         border: Border.all(
                  //             color: state.appLanguage == "ar"
                  //                 ? Theme.of(context).primaryColor
                  //                 : Colors.transparent,
                  //             width: 2)),
                  //     child: Column(
                  //       children: [
                  //         const Image(
                  //           image: AssetImage("assets/images/flag/sa.png"),
                  //           height: 50,
                  //           width: 50,
                  //         ),
                  //         const Gap(8),
                  //         Expanded(
                  //           child: Text(
                  //             "Arabic (ar)",
                  //             overflow: TextOverflow.ellipsis,
                  //             style: Theme.of(context)
                  //                 .listTileTheme
                  //                 .titleTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     BlocProvider.of<ThemeBloc>(context)
                  //         .add(SetLanguage("hi"));
                  //   },
                  //   child: Container(
                  //     height: 120,
                  //     width: MediaQuery.of(context).size.width * 0.41,
                  //     margin: const EdgeInsets.symmetric(
                  //         horizontal: 8, vertical: 8),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 16),
                  //     decoration: BoxDecoration(
                  //         color: Theme.of(context).listTileTheme.tileColor,
                  //         borderRadius: BorderRadius.circular(14),
                  //         border: Border.all(
                  //             color: state.appLanguage == "hi"
                  //                 ? Theme.of(context).primaryColor
                  //                 : Colors.transparent,
                  //             width: 2)),
                  //     child: Column(
                  //       children: [
                  //         const Image(
                  //           image: AssetImage("assets/images/flag/in.png"),
                  //           height: 50,
                  //           width: 50,
                  //         ),
                  //         const Gap(8),
                  //         Expanded(
                  //           child: Text(
                  //             "India (hi)",
                  //             overflow: TextOverflow.ellipsis,
                  //             style: Theme.of(context)
                  //                 .listTileTheme
                  //                 .titleTextStyle,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
