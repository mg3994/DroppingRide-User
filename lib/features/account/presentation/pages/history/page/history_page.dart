import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/l10n/app_localizations.dart';
import '../../../../../../common/common.dart';
import '../../../../../../core/utils/custom_loader.dart';
import '../../../../../../core/utils/custom_text.dart';
import '../../../../application/acc_bloc.dart';
import '../widget/history_card_shimmer.dart';
import '../../../widgets/top_bar.dart';
import '../../outstation/widget/outstation_offered_page.dart';
import '../widget/history_card_widget.dart';
import '../widget/history_nodata.dart';
import 'trip_summary_history.dart';

class HistoryPage extends StatelessWidget {
  static const String routeName = '/historyPage';

  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => AccBloc()
        ..add(AccGetDirectionEvent())
        ..add(HistoryPageInitEvent()),
      child: BlocListener<AccBloc, AccState>(
        listener: (context, state) {
          if (state is AccInitialState) {
            CustomLoader.loader(context);
          } else if (state is HistoryDataLoadingState) {
            CustomLoader.loader(context);
          } else if (state is HistoryDataSuccessState) {
            CustomLoader.dismiss(context);
          }
        },
        child: BlocBuilder<AccBloc, AccState>(
          builder: (context, state) {
            return Directionality(
              textDirection: context.read<AccBloc>().textDirection == 'rtl'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: TopBarDesign(
                icon: const Icon(Icons.dashboard_rounded), //TODO: Change
                  isHistoryPage: true,
                  controller: context.read<AccBloc>().scrollController,
                  title: AppLocalizations.of(context)!.history,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<AccBloc>().scrollController.dispose();
                  },
                  subTitleWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildTab(
                                    context: context,
                                    title:
                                        AppLocalizations.of(context)!.completed,
                                    index: 0,
                                    selectedIndex: context.read<AccBloc>().selectedHistoryType),
                                _buildTab(
                                    context: context,
                                    title:
                                        AppLocalizations.of(context)!.upcoming,
                                    index: 1,
                                    selectedIndex: context.read<AccBloc>().selectedHistoryType),
                                _buildTab(
                                    context: context,
                                    title:
                                        AppLocalizations.of(context)!.cancelled,
                                    index: 2,
                                    selectedIndex: context.read<AccBloc>().selectedHistoryType),
                              ],
                            ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (context.read<AccBloc>().isLoading &&
                          context.read<AccBloc>().firstLoad)
                        HistoryShimmer(size: size),
                      if (!context.read<AccBloc>().isLoading &&
                          context.read<AccBloc>().historyList.isEmpty)
                        const HistoryNodataWidget(),
                      if (context.read<AccBloc>().historyList.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            spacing: 4,
                            children: [
                              Row(
                                children: [
                                  MyText(
                                    text: AppLocalizations.of(context)!
                                        .historyDetails,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                  ),
                                   
                                ],
                              ),
                              DottedLine(
                          // ADDED: BY MG: Dotted line
                          dashLength: 2,
                          dashGapLength: 2,
                          dashRadius: 1,
                          lineThickness: 1,
                          dashColor: Theme.of(context).dividerColor,
                        ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: size.width * 0.05),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: context.read<AccBloc>().historyList.length,
                            itemBuilder: (_, index) {
                              final history = context
                                  .read<AccBloc>()
                                  .historyList
                                  .elementAt(index);
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: InkWell(
                                        onTap: () {
                                          if (history.isLater == true &&
                                              history.isCancelled != 1) {
                                            if (history.isOutStation == 1 &&
                                                history.driverDetail ==
                                                    null) {
                                              Navigator.pushNamed(
                                                  context,
                                                  OutStationOfferedPage
                                                      .routeName,
                                                  arguments:
                                                      OutStationOfferedPageArguments(
                                                    requestId: history.id,
                                                    currencySymbol: history
                                                        .requestedCurrencySymbol,
                                                    dropAddress:
                                                        history.dropAddress,
                                                    pickAddress:
                                                        history.pickAddress,
                                                    updatedAt: history
                                                        .tripStartTimeWithDate,
                                                    offeredFare: history
                                                        .offerredRideFare
                                                        .toString(),
                                                    // userData: context
                                                    //     .read<AccBloc>()
                                                    //     .userData!
                                                  )).then(
                                                (value) {
                                                  if (!context.mounted) return;
                                                  context
                                                      .read<AccBloc>()
                                                      .historyList
                                                      .clear();
                                                  context.read<AccBloc>().add(
                                                      HistoryGetEvent(
                                                          historyFilter:
                                                              'is_later=1'));
                                                },
                                              );
                                            } else {
                                              Navigator.pushNamed(
                                                context,
                                                HistoryTripSummaryPage
                                                    .routeName,
                                                arguments:
                                                    HistoryPageArguments(
                                                  historyData: history,
                                                ),
                                              ).then((value) {
                                                if (!context.mounted) return;
                                                context
                                                    .read<AccBloc>()
                                                    .historyList
                                                    .clear();
                                                context.read<AccBloc>().add(
                                                      HistoryGetEvent(
                                                          historyFilter:
                                                              'is_later=1'),
                                                    );
                                                context
                                                    .read<AccBloc>()
                                                    .add(AccUpdateEvent());
                                              });
                                            }
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              HistoryTripSummaryPage
                                                  .routeName,
                                              arguments: HistoryPageArguments(
                                                historyData: history,
                                              ),
                                            );
                                          }
                                        },
                                        child: HistoryCardWidget(
                                            cont: context, history: history)),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      if (context
                              .read<AccBloc>()
                              .walletHistoryList
                              .isNotEmpty &&
                          context.read<AccBloc>().loadMore)
                        Center(
                          child: SizedBox(
                              height: size.width * 0.08,
                              width: size.width * 0.08,
                              child: const CircularProgressIndicator()),
                        ),
                      SizedBox(height: size.width * 0.2),
                    ],
                  ),
                ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTab(
      {required BuildContext context,
      required String title,
      required int index,
      required int selectedIndex}) {
    return InkWell(
      onTap: () {
        if (index != selectedIndex && (!context.read<AccBloc>().isLoading && !context.read<AccBloc>().loadMore)) {
          context.read<AccBloc>().historyList.clear();
          context.read<AccBloc>().add(AccUpdateEvent());
          context
              .read<AccBloc>()
              .add(HistoryTypeChangeEvent(historyTypeIndex: index));
        }
      },
      child: Stack(
        children: [
          MyText(
            text: title,
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteText),
          ),
          if (index == selectedIndex)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 15,
                  height: 2,
                  color: AppColors.white.withOpacity(0.8)),
            ),
        ],
      ),
    );
  }
}
