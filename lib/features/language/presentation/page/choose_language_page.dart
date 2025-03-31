import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../core/utils/custom_background.dart';
import '../../../../core/utils/custom_loader.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../landing/presentation/page/landing_page.dart';
import '../../application/language_bloc.dart';
import '../../../../app/localization.dart';
import '../../domain/models/language_listing_model.dart';
import 'package:dotted_line/dotted_line.dart';
class ChooseLanguagePage extends StatelessWidget {
  static const String routeName = '/chooseLanguage';
  final ChooseLanguageArguments arg;

  const ChooseLanguagePage({super.key, required this.arg});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return builderList(size);
  }

  Widget builderList(Size size) {
    return BlocProvider(
      create: (context) => LanguageBloc()
        ..add(LanguageInitialEvent())
        ..add(LanguageGetEvent(
            isInitialLanguageChange: arg.isInitialLanguageChange)),
      child: BlocListener<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is LanguageInitialState) {
            CustomLoader.loader(context);
          } else if (state is LanguageLoadingState) {
            CustomLoader.loader(context);
          } else if (state is LanguageSuccessState) {
            CustomLoader.dismiss(context);
          } else if (state is LanguageFailureState) {
            CustomLoader.dismiss(context);
          } else if (state is LanguageUpdateState) {
            // Reload the app with the selected language
            if (arg.isInitialLanguageChange) {
              Navigator.pushNamedAndRemoveUntil(
                  context, LandingPage.routeName, (route) => false);
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child:
                //  CustomBackground(child: 
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.width * 0.05),
                        Row(
                          children: [
                            (arg.isInitialLanguageChange)
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.read<LocalizationBloc>().add(
                                          LocalizationInitialEvent(
                                            isDark: Theme.of(context)
                                                      .brightness ==
                                                  Brightness.dark,
                                              locale: Locale(context
                                                  .read<LanguageBloc>()
                                                  .choosedLanguage)));
                                    },
                                    icon:  Icon(
                                      Icons.arrow_back_ios,
                                      color: Theme.of(context).primaryColorDark,
                                      size: 20,
                                    ),
                                  ),
                            MyText(
                                text: AppLocalizations.of(context)!
                                    .chooseLanguage,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      // color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                          ],
                        ),
                        SizedBox(height: size.width * 0.02),
                        DottedLine( // ADDED: BY MG: Dotted line
                         dashLength: 2,
                          dashGapLength: 2,
                          dashRadius: 1,
                          lineThickness: 1,
                          dashColor: Theme.of(context).dividerColor,
                        ),
                        SizedBox(height: size.width * 0.02),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // buildLanguageList(size,
                                //     context.read<LanguageBloc>().languageList),
                                buildLanguageList(
                                    size, AppConstants.languageList)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        confirmButton(size, context),
                      ],
                    ),
                  ),
                // ),
              ),
            );
          },
        ),
      ),
    );
  }

// Language List
  Widget buildLanguageList(Size size, List<LocaleLanguageList> languageList) {
    return languageList.isNotEmpty
        ? RawScrollbar(
            radius: const Radius.circular(20),
            child: ListView.builder(
              itemCount: languageList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      context.read<LanguageBloc>().add(
                          LanguageSelectEvent(selectedLanguageIndex: index));
                      context.read<LocalizationBloc>().add(
                          LocalizationInitialEvent(
                            isDark: Theme.of(context).brightness ==
                                  Brightness.dark,
                              locale: Locale(languageList[index].lang)));
                    },
                    child: Container(
                      height: 50,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color:
                                (context.read<LanguageBloc>().selectedIndex ==
                                        index)
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).dividerColor.withAlpha(100),
                            width:
                                (context.read<LanguageBloc>().selectedIndex ==
                                        index)
                                    ? 2.0
                                    : 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            spacing: 4,
                            children: [
                                  CachedNetworkImage(imageUrl: 
                            languageList[index].flag,
                                height: 22,
                                width:35,
                                // placeholder: (context, url) {
                                //   return const Icon(Icons.error);
                                // },
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                                progressIndicatorBuilder: (context, url, progress) {
                                    return Center(
                                    child: SizedBox(
                                      height: 12,
                                      width: 12,
                                      child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      value: progress.progress,
                                      ),
                                    ),
                                    );
                                },
                              ),
                              MyText(
                                text: languageList[index].name,
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge!
                                    // .copyWith(
                                    //       color: Theme.of(context).primaryColorDark,
                                    //     ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }

  Widget confirmButton(Size size, BuildContext context) {
    return Center(
      child: CustomButton(
         borderRadius: 4,
        buttonName: AppLocalizations.of(context)!.confirm,
        height: size.width * 0.15,
        width: size.width * 0.85,
        onTap: () async {
          final selectedIndex = context.read<LanguageBloc>().selectedIndex;
          context.read<LanguageBloc>().add(LanguageSelectUpdateEvent(
              // selectedLanguage: context
              //     .read<LanguageBloc>()
              //     .languageList
              //     .elementAt(selectedIndex)
              //     .lang
              selectedLanguage:
                  AppConstants.languageList.elementAt(selectedIndex).lang));
        },
      ),
    );
  }
}
