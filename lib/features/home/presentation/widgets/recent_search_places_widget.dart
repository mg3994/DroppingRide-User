import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/core/utils/custom_card.dart';
import 'package:restart_tagxi/l10n/app_localizations.dart';

import '../../../../core/utils/custom_text.dart';
import '../../application/home_bloc.dart';

class RecentSearchPlacesWidget extends StatelessWidget {
  final BuildContext cont;
  const RecentSearchPlacesWidget({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: cont.read<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CustomCard(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
 borderRadius: 4,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                 padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                    MyText(
                   text: AppLocalizations.of(context)!
                       .recentSearchHistory,
                   textStyle: Theme.of(context)
                       .textTheme
                       .bodyMedium!
                       .copyWith(
                           fontWeight: FontWeight.bold,
                           color: Theme.of(context)
                               .primaryColorDark)),
                                    DottedLine( // ADDED: BY MG: Dotted line
                                    dashLength: 2,
                                    dashGapLength: 2,
                                    dashRadius: 1,
                                    lineThickness: 1,
                                    dashColor: Theme.of(context).dividerColor,
                                  ),
                                      SizedBox(height: size.width * 0.02),
                  ],),
                ),
                ListView.builder(
                  itemCount: context.read<HomeBloc>().recentSearchPlaces.length > 2
                      ? 2
                      : context.read<HomeBloc>().recentSearchPlaces.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final recentPlace = context
                        .read<HomeBloc>()
                        .recentSearchPlaces
                        .reversed
                        .elementAt(index);
                    return InkWell(
                      onTap: () {
                        if (context.read<HomeBloc>().pickupAddressList.isNotEmpty) {
                          if (context
                                      .read<HomeBloc>()
                                      .userData!
                                      .enableModulesForApplications ==
                                  'both' ||
                              context
                                      .read<HomeBloc>()
                                      .userData!
                                      .enableModulesForApplications ==
                                  'taxi') {
                            context.read<HomeBloc>().add(RecentSearchPlaceSelectEvent(
                                address: recentPlace,
                                isPickupSelect: false,
                                transportType: 'taxi'));
                          } else {
                            context
                                .read<HomeBloc>()
                                .add(ServiceTypeChangeEvent(serviceTypeIndex: 1));
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            height: size.height * 0.075,
                            width: size.width * 0.075,
                            decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.history,
                              size: 18,
                              color: Theme.of(context).disabledColor.withOpacity(0.75),
                            ),
                          ),
                          SizedBox(width: size.width * 0.025),
                          SizedBox(
                            width: size.width * 0.63,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyText(
                                  text: recentPlace.address.split(',')[0],
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  maxLines: 1,
                                ),
                                MyText(
                                  text: recentPlace.address,
                                  textStyle:
                                      Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: Theme.of(context).disabledColor,
                                          ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
