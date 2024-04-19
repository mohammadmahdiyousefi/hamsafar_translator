import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:translator/bloc/translator_screen/translator_bloc.dart';
import 'package:translator/model/list_of_country.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectToLanguage extends StatefulWidget {
  const SelectToLanguage({super.key});

  @override
  State<SelectToLanguage> createState() => _SelectToLanguageState();
}

class _SelectToLanguageState extends State<SelectToLanguage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(AppLocalizations.of(context)!.languageAppBar,
              style: Theme.of(context).appBarTheme.titleTextStyle),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color,
            ),
          )),
      body: Column(
        children: [
          Container(
              height: 65,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                  color: Theme.of(context).listTileTheme.tileColor,
                  borderRadius: BorderRadius.circular(14)),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: controller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.searchHintText,
                    hintStyle:
                        Theme.of(context).listTileTheme.subtitleTextStyle,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    )),
              )),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listOfCountry.length,
              itemBuilder: (context, index) {
                return Visibility(
                  visible: listOfCountry[index]
                      .language
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<TranslatorBloc>(context)
                          .add(TranslatorEventSetTo(to: listOfCountry[index]));
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                          color: Theme.of(context).listTileTheme.tileColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(listOfCountry[index].flag),
                            height: 35,
                            width: 35,
                          ),
                          const Gap(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listOfCountry[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .listTileTheme
                                      .titleTextStyle,
                                ),
                                const Gap(2),
                                Text(listOfCountry[index].language,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .listTileTheme
                                        .subtitleTextStyle)
                              ],
                            ),
                          ),
                          const Gap(7),
                          Text(listOfCountry[index].code,
                              style: Theme.of(context)
                                  .listTileTheme
                                  .subtitleTextStyle)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
