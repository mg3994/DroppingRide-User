import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../application/booking_bloc.dart';

class SelectPreferenceWidget extends StatelessWidget {
  final BuildContext cont;
  const SelectPreferenceWidget({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: cont.read<BookingBloc>(),
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          return Container(
            width: size.width,
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: AppLocalizations.of(context)!.preference,
                      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel_outlined)),
                  ],
                ),
                   DottedLine( // ADDED: BY MG: Dotted line
                                      dashLength: 2,
                                      dashGapLength: 2,
                                      dashRadius: 1,
                                      lineThickness: 1,
                                      dashColor: Theme.of(context).dividerColor,
                                    ),
                SizedBox(height: size.width * 0.05),
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Theme.of(context).primaryColorDark,
                  ),
                  child: CheckboxListTile(
                      value: context.read<BookingBloc>().luggagePreference,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        context.read<BookingBloc>().luggagePreference = value!;
                        context.read<BookingBloc>().add(UpdateEvent());
                      },
                      title: MyText(
                        text: AppLocalizations.of(context)!.luggage,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                ),
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Theme.of(context).primaryColorDark,
                  ),
                  child: CheckboxListTile(
                      value: context.read<BookingBloc>().petPreference,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        context.read<BookingBloc>().petPreference = value!;
                        context.read<BookingBloc>().add(UpdateEvent());
                      },
                      title: MyText(
                        text: AppLocalizations.of(context)!.pet,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
