import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/core/utils/custom_card.dart';

import '../../../../../../common/common.dart';
import '../../../../../../common/pickup_icon.dart';
import '../../../../../../core/utils/custom_divider.dart';
import '../../../../../../core/utils/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../application/booking_bloc.dart';
import 'eta_list_view_widget.dart';
import 'rental_ride/rental_eta_list_view.dart';

class RidePreviewWidget extends StatelessWidget {
  final BuildContext cont;
  final BookingPageArguments arg;
  const RidePreviewWidget({super.key, required this.cont, required this.arg});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(value: cont.read<BookingBloc>(),
    child: BlocBuilder<BookingBloc,BookingState>(builder: (context, state) {
      return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-1, -2),
            blurRadius: 10,
            spreadRadius: 2,
            color: Theme.of(context).shadowColor,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor, //
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4), //
                topRight: Radius.circular(4), //
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: !context.read<BookingBloc>().showBiddingVehicles
                        ? size.width * 0.05
                        : size.width * 0.05),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CustomDivider()),
                  ],
                ),
                if (arg.userData.enableModulesForApplications ==
                        'both' &&
                    arg.isOutstationRide)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      children: [
                        if (arg.userData.showTaxiOutstationRideFeature ==
                            '1')
                          SizedBox(
                            width: size.width * 0.25,
                            child: Theme(
                              data: ThemeData(
                                  listTileTheme: const ListTileThemeData(
                                    contentPadding: EdgeInsets.zero,
                                    horizontalTitleGap: 0,
                                  ),
                                  unselectedWidgetColor:
                                      Theme.of(context).primaryColorDark),
                              child: RadioListTile(
                                value: 'taxi',
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                activeColor: Theme.of(context).primaryColorDark,
                                groupValue:
                                    context.read<BookingBloc>().transportType,
                                onChanged: (value) {
                                  context
                                      .read<BookingBloc>()
                                      .selectedPackageIndex = 0;
                                  context.read<BookingBloc>().transportType =
                                      value!;
                                  context.read<BookingBloc>().add(
                                      BookingEtaRequestEvent(
                                          picklat: arg.picklat,
                                          picklng: arg.picklng,
                                          droplat: arg.droplat,
                                          droplng: arg.droplng,
                                          ridetype: 1,
                                          transporttype: value,
                                          distance: context
                                              .read<BookingBloc>()
                                              .distance,
                                          duration: context
                                              .read<BookingBloc>()
                                              .duration,
                                          polyLine: arg.polyString,
                                          pickupAddressList: context
                                              .read<BookingBloc>()
                                              .pickUpAddressList,
                                          dropAddressList: context
                                              .read<BookingBloc>()
                                              .dropAddressList,
                                          isOutstationRide:
                                              arg.isOutstationRide,
                                          isWithoutDestinationRide: arg
                                                  .isWithoutDestinationRide ??
                                              false));
                                  context
                                      .read<BookingBloc>()
                                      .add(UpdateEvent());
                                },
                                title: MyText(
                                    text: AppLocalizations.of(context)!.taxi,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ),
                          ),
                        if (arg.userData
                                .showDeliveryOutstationRideFeature ==
                            '1')
                          SizedBox(
                            width: size.width * 0.35,
                            child: Theme(
                              data: ThemeData(
                                  listTileTheme: const ListTileThemeData(
                                    contentPadding: EdgeInsets.zero,
                                    horizontalTitleGap: 0,
                                  ),
                                  unselectedWidgetColor:
                                      Theme.of(context).primaryColorDark),
                              child: RadioListTile(
                                value: 'delivery',
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                activeColor: Theme.of(context).primaryColorDark,
                                groupValue:
                                    context.read<BookingBloc>().transportType,
                                onChanged: (value) {
                                  context
                                      .read<BookingBloc>()
                                      .selectedPackageIndex = 0;
                                  context.read<BookingBloc>().transportType =
                                      value!;
                                  context.read<BookingBloc>().add(
                                      BookingEtaRequestEvent(
                                          picklat: arg.picklat,
                                          picklng: arg.picklng,
                                          droplat: arg.droplat,
                                          droplng: arg.droplng,
                                          ridetype: 1,
                                          transporttype: value,
                                          distance: context
                                              .read<BookingBloc>()
                                              .distance,
                                          duration: context
                                              .read<BookingBloc>()
                                              .duration,
                                          polyLine: arg.polyString,
                                          pickupAddressList: context
                                              .read<BookingBloc>()
                                              .pickUpAddressList,
                                          dropAddressList: context
                                              .read<BookingBloc>()
                                              .dropAddressList,
                                          isOutstationRide:
                                              arg.isOutstationRide,
                                          isWithoutDestinationRide: arg
                                                  .isWithoutDestinationRide ??
                                              false));
                                  context
                                      .read<BookingBloc>()
                                      .add(UpdateEvent());
                                },
                                title: MyText(
                                    text:
                                        AppLocalizations.of(context)!.delivery,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                SizedBox(height: size.width * 0.04),
                CustomCard(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.width * 0.02),

                  child: ListView.builder(
                      itemCount: arg.pickupAddressList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final address =
                            arg.pickupAddressList.elementAt(index);
                        return Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.018),
                              child: const PickupIcon(),
                            ),
                            Expanded(
                              child: MyText(
                                text: address.address,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                if (arg.stopAddressList.isNotEmpty) ...[
                  SizedBox(height: size.width * 0.02),
                   DottedLine( // ADDED: BY MG: Dotted line
                                  dashLength: 2,
                                  dashGapLength: 2,
                                  dashRadius: 1,
                                  lineThickness: 1,
                                  dashColor: Theme.of(context).dividerColor.withOpacity(0.4),
                                ),
                  // Divider(
                  //     indent: size.width * 0.12,
                  //     endIndent: size.width * 0.05,
                  //     color: Theme.of(context).dividerColor.withOpacity(0.4)),
                  ListView.separated(
                    itemCount: arg.stopAddressList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final address =
                          arg.stopAddressList.elementAt(index);
                      return Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.015),
                            child: const DropIcon(),
                          ),
                          Expanded(
                            child: MyText(
                              text: address.address,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return  DottedLine( // ADDED: BY MG: Dotted line
                                  dashLength: 2,
                                  dashGapLength: 2,
                                  dashRadius: 1,
                                  lineThickness: 1,
                                  dashColor: Theme.of(context).dividerColor.withOpacity(0.4),
                                );
                    },
                  ),
                  SizedBox(height: size.width * 0.02),
                   DottedLine( // ADDED: BY MG: Dotted line
                                  dashLength: 2,
                                  dashGapLength: 2,
                                  dashRadius: 1,
                                  lineThickness: 1,
                                  dashColor: Theme.of(context).dividerColor.withOpacity(0.4),
                                ),
                  SizedBox(height: size.width * 0.03),
                ],
                if (!context.read<BookingBloc>().isRentalRide &&
                    context.read<BookingBloc>().etaDetailsList.isNotEmpty) ...[
                  EtaListViewWidget(cont: context,arg: arg,thisValue: this),
                ],
                if (context.read<BookingBloc>().isRentalRide &&
                    context
                        .read<BookingBloc>()
                        .rentalEtaDetailsList
                        .isNotEmpty) ...[
                  // SizedBox(height: size.width * 0.02),
                  RentalEtaListViewWidget(cont: context,arg: arg,thisValue: this),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  
    },),);
  }
}