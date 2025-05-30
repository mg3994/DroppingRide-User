import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/core/utils/custom_card.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/pickup_icon.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/home_bloc.dart';

class HomeOnGoingRidesWidget extends StatelessWidget {
  final BuildContext cont;
  const HomeOnGoingRidesWidget({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(value: cont.read<HomeBloc>(),
    child: BlocBuilder<HomeBloc,HomeState>(builder: (context, state) {
      return CustomCard(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        borderRadius: 4,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Padding(
          padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
          child: Column( children:[
           Row(
             mainAxisAlignment:
                 MainAxisAlignment.spaceBetween,
             children: [
               MyText(
                   text: AppLocalizations.of(context)!
                       .onGoingRides,
                   textStyle: Theme.of(context)
                       .textTheme
                       .bodyMedium!
                       .copyWith(
                           fontWeight: FontWeight.bold,
                           color: Theme.of(context)
                               .primaryColorDark)),
             ],
           ),
                                        DottedLine( // ADDED: BY MG: Dotted line
                                    dashLength: 2,
                                    dashGapLength: 2,
                                    dashRadius: 1,
                                    lineThickness: 1,
                                    dashColor: Theme.of(context).dividerColor,
                                  ),
                                      SizedBox(height: size.width * 0.02),
          CarouselSlider(
            items: List.generate(
              (context.read<HomeBloc>().onGoingRideList.length > 3
                  ? 3
                  : context.read<HomeBloc>().onGoingRideList.length),
              (index) {
                final ride =
                    context.read<HomeBloc>().onGoingRideList.elementAt(index);
                return InkWell(
                  onTap: () {
                    context
                        .read<HomeBloc>()
                        .add(OnGoingRideOnTapEvent(selectedIndex: index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: (context.read<HomeBloc>().textDirection == 'ltr')
                          ? size.width * 0.025
                          : 0,
                      left: (context.read<HomeBloc>().textDirection == 'rtl')
                          ? size.width * 0.025
                          : 0,
                    ),
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //     width: 1.2,
                        //     color:
                        //         Theme.of(context).disabledColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(size.width * 0.02)),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(size.width * 0.02,
                              size.width * 0.02, size.width * 0.02, 0),
                          height: size.width * 0.2,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.1),
                              // border: Border(
                              //   bottom: BorderSide(
                              //       width: 1,
                              //       color: Theme.of(context)
                              //           .disabledColor
                              //           .withOpacity(0.5)),
                              // )
                              ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const PickupIcon(),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Expanded(
                                    child: MyText(
                                      text: ride.pickAddress,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              if (ride.dropAddress.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const DropIcon(),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Expanded(
                                      child: MyText(
                                        text: ride.dropAddress,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                              SizedBox(height: size.height * 0.01),

                        DottedLine( // ADDED: BY MG: Dotted line
                                    dashLength: 2,
                                    dashGapLength: 2,
                                    dashRadius: 1,
                                    lineThickness: 1,
                                    dashColor: Theme.of(context).dividerColor,
                                  ),
                        Container(
                          padding: EdgeInsets.all(size.width * 0.02),
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: ride.driverDetail.data.carNumber,
                                      textStyle:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    MyText(
                                      text: ride.driverDetail.data.vehicleTypeName
                                          .toString(),
                                      textStyle:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: size.width * 0.24,
                                  height: size.width * 0.08,
                                  decoration: BoxDecoration(
                                   boxShadow: [
          BoxShadow(
          color: (ride.acceptedAt != "" &&
                                                        ride.isDriverArrived == 0)
                                                    ? Theme.of(context).primaryColor
                                                    : (ride.isDriverArrived == 1 &&
                                                            ride.isTripStart == 0)
                                                        ? Theme.of(context).primaryColor
                                                        : AppColors.green,
            // blurRadius: 0,
            spreadRadius:1.2,
            blurStyle: BlurStyle.solid,
            offset: const Offset(-2, 0),
          ),
        ],
                 color: (ride.acceptedAt != "" &&
                                                        ride.isDriverArrived == 0)
        ? Color.lerp(Colors.white, Theme.of(context).primaryColor, 0.2) // Light green splash
        :(ride.isDriverArrived == 1 &&
                                                            ride.isTripStart == 0)
            ? Color.lerp(Colors.white, Theme.of(context).primaryColor, 0.2) // Light red splash
            // Light secondary color
                : Color.lerp(Colors.white, AppColors.green, 0.2), // Light primary color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
                                    child: Center(
                                      child: MyText(
                                          text: (ride.acceptedAt != "" &&
                                                  ride.isDriverArrived == 0)
                                              ? AppLocalizations.of(context)!.accepted
                                              : (ride.isDriverArrived == 1 &&
                                                      ride.isTripStart == 0)
                                                  ? AppLocalizations.of(context)!
                                                      .arrived
                                                  : (ride.isCompleted == 1)
                                                      ? AppLocalizations.of(context)!
                                                          .completed
                                                      : AppLocalizations.of(context)!
                                                          .tripStarted,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: (ride.acceptedAt != "" &&
                                                        ride.isDriverArrived == 0)
                                                    ? Theme.of(context).primaryColor
                                                    : (ride.isDriverArrived == 1 &&
                                                            ride.isTripStart == 0)
                                                        ? Theme.of(context).primaryColor
                                                        : AppColors.green,
                                              )),
                                    ),
                                  ),
                                  MyText(
                                      text:
                                          '${ride.paymentTypeString.toString()} ${ride.requestedCurrencySymbol}${ride.requestEtaAmount.toString()}',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            options: CarouselOptions(
              height: size.width * 0.375,
              aspectRatio: 16 / 9,
              viewportFraction: 0.95,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 300),
              autoPlayCurve: Curves.ease,
              enlargeCenterPage: false,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                context.read<HomeBloc>().onGoingRideIndex = index;
                context.read<HomeBloc>().add(UpdateEvent());
              },
            ),
          ),]),
        ),
        SizedBox(height: size.width * 0.025),
        if (context.read<HomeBloc>().onGoingRideList.length > 1)
          Padding(
            padding: EdgeInsets.only(
              right: (context.read<HomeBloc>().textDirection == 'ltr')
                  ? size.width * 0.025
                  : 0,
              left: (context.read<HomeBloc>().textDirection == 'rtl')
                  ? size.width * 0.025
                  : 0,
            ),
            child: Row(
              mainAxisAlignment:
                  (context.read<HomeBloc>().onGoingRideList.length > 3)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
              children: [
                if (context.read<HomeBloc>().onGoingRideList.length > 3)
                  const SizedBox(width: 1),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    (context.read<HomeBloc>().onGoingRideList.length > 3
                        ? 3
                        : context.read<HomeBloc>().onGoingRideList.length),
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: size.width * 0.02,
                          width: size.width * 0.02,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.read<HomeBloc>().onGoingRideIndex ==
                                      index
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight),
                        ),
                      );
                    },
                  ),
                ),
                if (context.read<HomeBloc>().isMultipleRide) ...[
                  if (context.read<HomeBloc>().onGoingRideList.length > 3)
                    InkWell(
                      onTap: () {
                        context
                            .read<HomeBloc>()
                            .add(NavigateToOnGoingRidesPageEvent());
                      },
                      child: MyText(
                          text: AppLocalizations.of(context)!.view,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColorDark)),
                    ),
                ],
              ],
            ),
          )
            ],
          ),
      );

    },),);
  }
}
