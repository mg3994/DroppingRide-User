import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/core/utils/custom_card.dart';

import '../../../../../../common/common.dart';
import '../../../../../../common/pickup_icon.dart';
import '../../../../../../core/utils/custom_loader.dart';
import '../../../../../../core/utils/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../application/acc_bloc.dart';
import '../../../../domain/models/history_model.dart';

class HistoryCardWidget extends StatelessWidget {
  final BuildContext cont;
  final HistoryData history;
  const HistoryCardWidget(
      {super.key, required this.cont, required this.history});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: cont.read<AccBloc>(),
      child: BlocBuilder<AccBloc, AccState>(
        builder: (context, state) {
          return CustomCard(
            borderRadius: 6,
            margin: EdgeInsets.only(bottom: size.width * 0.02),
            // decoration: BoxDecoration(
            //   color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
            //   borderRadius: BorderRadius.circular(10),
            //   border: Border.all(
            //     width: size.width * 0.001,
            //     color: Theme.of(context).disabledColor,
            //   ),
            // ),
            child: Column(
              children: [
                Container(
                   decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Column(children:[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PickupIcon(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: MyText(
                              overflow: TextOverflow.ellipsis,
                              text: history.pickAddress,
                              textStyle: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        MyText(
                          text: history.cvTripStartTime,
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (!history.isRental && history.dropAddress.isNotEmpty)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const DropIcon(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: MyText(
                                overflow: TextOverflow.ellipsis,
                                text: (history.requestStops != null &&
                                        history.requestStops!.data.isNotEmpty)
                                    ? history.requestStops!.data.last.address
                                    : history.dropAddress,
                                textStyle: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                          MyText(
                            text: history.cvCompletedAt,
                            textStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).disabledColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                                ]),
                ),
                SizedBox(height: size.width * 0.03),
                 DottedLine( // ADDED: BY MG: Dotted line
                                dashLength: 2,
                                dashGapLength: 2,
                                dashRadius: 1,
                                lineThickness: 1,
                                dashColor: Theme.of(context).dividerColor,
                              ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.025),
                  // decoration: BoxDecoration(
                  //   color: Theme.of(context).scaffoldBackgroundColor,
                  //   borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(10),
                  //       bottomRight: Radius.circular(10)),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (history.isOutStation != 1)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: history.laterRide == true
                                      ? history.tripStartTimeWithDate
                                      : history.isCompleted == 1
                                          ? history.convertedCompletedAt
                                          : history.isCancelled == 1
                                              ? history.convertedCancelledAt
                                              : history.convertedCreatedAt,
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      child: CachedNetworkImage(
                                        imageUrl: history.vehicleTypeImage,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: Loader(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Text(""),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.025,
                                    ),
                                    MyText(
                                      text: history.vehicleTypeName,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      text: (history.isOutStation == 1 &&
                                              history.isRoundTrip != '')
                                          ? AppLocalizations.of(context)!
                                              .roundTrip
                                          : AppLocalizations.of(context)!
                                              .oneWayTrip,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                    ),
                                    if (history.isOutStation == 1 &&
                                        history.isRoundTrip != '')
                                      const Icon(Icons.import_export)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // color: Theme.of(context)
                                          //     .scaffoldBackgroundColor
                                              ),
                                      child: CachedNetworkImage(
                                        imageUrl: history.vehicleTypeImage,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: Loader(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Text(""),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.025,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (history.isOutStation == 1 &&
                                            history.isCancelled != 1 &&
                                            history.isCompleted != 1)
                                          MyText(
                                            text: (history.driverDetail != null)
                                                ? AppLocalizations.of(context)!
                                                    .assigned
                                                : AppLocalizations.of(context)!
                                                    .unAssigned,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        (history.driverDetail !=
                                                                null)
                                                            ? AppColors.green
                                                            : AppColors.red),
                                          ),
                                        MyText(
                                          text: history.vehicleTypeName,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium?.copyWith(fontWeight:FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      (history.isOutStation != 1)
                          ? Column(
                            spacing: 4,
                              // crossAxisAlignment: CrossAxisAlignment,
                              children: [
                                Container(
                                  width: size.width * 0.24,
                                  height: size.width * 0.08,
                                   decoration: BoxDecoration(
                                   boxShadow: [
          BoxShadow(
           color: history.isCompleted == 1
                                              ? AppColors.green
                                              : history.isCancelled == 1
                                                  ? AppColors.red
                                                  : history.isLater == true
                                                      ? AppColors.secondaryDark
                                                      : Theme.of(context)
                                                          .primaryColor,
            // blurRadius: 0,
            spreadRadius:1.2,
            blurStyle: BlurStyle.solid,
            offset: const Offset(-2, 0),
          ),
        ],
                 color: history.isCompleted == 1
        ? Color.lerp(Colors.white, AppColors.green, 0.2) // Light green splash
        : history.isCancelled == 1
            ? Color.lerp(Colors.white, AppColors.red, 0.2) // Light red splash
            : history.isLater == true
                ? Color.lerp(Colors.white, AppColors.secondaryDark, 0.2) // Light secondary color
                : Color.lerp(Colors.white, Theme.of(context).primaryColor, 0.2), // Light primary color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
                                  child: Center(
                                    child: MyText(
                                      text: history.isCompleted == 1
                                          ? AppLocalizations.of(context)!.completed
                                          : history.isCancelled == 1
                                              ? AppLocalizations.of(context)!
                                                  .cancelled
                                              : history.isLater == true
                                                  ? (history.isRental == false)
                                                      ? AppLocalizations.of(
                                                              context)!
                                                          .upcoming
                                                      : 'Rental ${history.rentalPackageName.toString()}'
                                                  : '',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            color: history.isCompleted == 1
                                                ? AppColors.green
                                                : history.isCancelled == 1
                                                    ? AppColors.red
                                                    : history.isLater == true
                                                        ? AppColors.secondaryDark
                                                        : Theme.of(context)
                                                            .primaryColor,
                                          ),
                                    ),
                                  ),
                                ),
                                MyText(
                                    text: (history.isBidRide == 1)
                                        ? '${history.requestedCurrencySymbol} ${history.acceptedRideFare}'
                                        : (history.isCompleted == 1)
                                            ? '${history.requestBill.data.requestedCurrencySymbol} ${history.requestBill.data.totalAmount}'
                                            : '${history.requestedCurrencySymbol} ${history.requestEtaAmount}',textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MyText(
                                  text: (history.laterRide == true &&
                                          history.isOutStation == 1)
                                      ? history.tripStartTime
                                      : (history.laterRide == true &&
                                              history.isOutStation != 1)
                                          ? history.tripStartTimeWithDate
                                          : history.isCompleted == 1
                                              ? history.convertedCompletedAt
                                              : history.isCancelled == 1
                                                  ? history.convertedCancelledAt
                                                  : history.convertedCreatedAt,
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                MyText(
                                  text: history.returnTime,
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                SizedBox(
                                  height: size.width * 0.025,
                                ),
                                Row(
                                  children: [
                                    MyText(
                                      text: (history.paymentOpt == '1')
                                          ? AppLocalizations.of(context)!.cash
                                          : (history.paymentOpt == '2')
                                              ? AppLocalizations.of(context)!
                                                  .wallet
                                              : (history.paymentOpt == '0')
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .card
                                                  : '',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                              // fontWeight: FontWeight.bold
                                          ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.025,
                                    ),
                                    MyText(
                                      text: (history.isOutStation == 1)
                                          ? '${history.requestedCurrencySymbol} ${history.offerredRideFare}'
                                          : (history.isBidRide == 1)
                                              ? '${history.requestedCurrencySymbol} ${history.acceptedRideFare}'
                                              : (history.isCompleted == 1)
                                                  ? '${history.requestBill.data.requestedCurrencySymbol} ${history.requestBill.data.totalAmount}'
                                                  : '${history.requestedCurrencySymbol} ${history.requestEtaAmount}',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                              fontWeight: FontWeight.bold
                                                // fontWeight: FontWeight.bold
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
