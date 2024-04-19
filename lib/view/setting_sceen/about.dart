import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:translator/bloc/updateversion/updateversion_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  String version = "";
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
            AppLocalizations.of(context)!.about,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(60),
                    Image.asset(
                      "assets/images/app_icon/Google-Translate-icon.png",
                      height: 120,
                      width: 120,
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.version,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Gap(8),
                        FutureBuilder(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, info) {
                              version = info.data != null
                                  ? info.data!.version
                                  : "0.0.0";
                              return Text(
                                version,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey),
                              );
                            }),
                      ],
                    ),
                    const Gap(8),
                    BlocBuilder<UpdateversionBloc, UpdateversionState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            state is UpdateversionLoading
                                ? const CircularProgressIndicator()
                                : TextButton(
                                    onPressed: () {
                                      BlocProvider.of<UpdateversionBloc>(
                                              context)
                                          .add(const GetUpadate());
                                    },
                                    child: Text(AppLocalizations.of(context)!
                                        .updateButton)),
                            const Gap(16),
                            state is UpdateversionData
                                ? state.data.version
                                            .substring(1)
                                            .compareTo(version) >
                                        0
                                    ? Container(
                                        height: 320,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, top: 8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .listTileTheme
                                              .tileColor,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .updateisavailable,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Text(
                                                "${AppLocalizations.of(context)!.currentversion} : $version"),
                                            const Gap(4),
                                            Text(
                                                "${AppLocalizations.of(context)!.newversion} : ${state.data.version.substring(1)}"),
                                            const Gap(16),
                                            Text(AppLocalizations.of(context)!
                                                .whatsnew),
                                            const Gap(8),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Text(state.data.body),
                                              ),
                                            ),
                                            const Gap(8),
                                            TextButton(
                                                onPressed: () async {
                                                  await canLaunchUrl(Uri.parse(
                                                          state.data.url))
                                                      .then((value) async {
                                                    if (value) {
                                                      await launchUrl(
                                                        Uri.parse(
                                                            state.data.url),
                                                      );
                                                    } else {
                                                      await launchUrl(
                                                          Uri.parse(
                                                              state.data.url),
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    }
                                                  });
                                                },
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .update))
                                          ],
                                        ),
                                      )
                                    : Text(AppLocalizations.of(context)!
                                        .currentlyUpdated)
                                : state is UpdateversionError
                                    ? Text(state.error)
                                    : const SizedBox()
                          ],
                        );
                      },
                    )
                  ]),
            )));
  }
}
