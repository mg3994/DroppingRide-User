import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/core/utils/custom_text.dart';
import 'package:restart_tagxi/l10n/app_localizations.dart';

import '../../../../../../core/utils/custom_button.dart';
import '../../../../application/booking_bloc.dart';

class AddTipWidget extends StatelessWidget {
  final BuildContext cont;
  final String requestId;
  final String currencySymbol;
  final String totalAmount;
  final String minimumTipAmount;
  const AddTipWidget(
      {super.key,
      required this.cont,
      required this.requestId,
      required this.currencySymbol,
      required this.totalAmount,required this.minimumTipAmount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
        value: cont.read<BookingBloc>(),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: size.width * 0.9,
                      height: size.width * 0.75,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                                text:
                                    '${AppLocalizations.of(context)!.tripFare}  $currencySymbol$totalAmount',
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge),
                            SizedBox(height: size.width * 0.02),
                            MyText(
                                text: AppLocalizations.of(context)!
                                    .showAppreciationTip,
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge),
                            SizedBox(height: size.width * 0.05),
                            Container(
                              height: size.width * 0.128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1.2,
                                    color: Theme.of(context).disabledColor),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 0.15,
                                    height: size.width * 0.128,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: Theme.of(context)
                                          .disabledColor
                                          .withOpacity(0.1),
                                    ),
                                    alignment: Alignment.center,
                                    child: MyText(text: currencySymbol),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Container(
                                    height: size.width * 0.128,
                                    width: size.width * 0.6,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: context
                                          .read<BookingBloc>()
                                          .addTIPController,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          context.read<BookingBloc>().addTip =
                                              double.parse(value);
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppLocalizations.of(context)!
                                            .enterAmountHere,
                                        hintStyle:
                                            const TextStyle(fontSize: 14),
                                      ),
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: size.width * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<BookingBloc>()
                                        .addTIPController
                                        .text = double.parse(minimumTipAmount).toString();
                                    context.read<BookingBloc>().addTip = double.parse(minimumTipAmount);
                                  },
                                  child: Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).disabledColor,
                                            width: 1.2),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(6)),
                                    alignment: Alignment.center,
                                    child: MyText(text: '$currencySymbol $minimumTipAmount'),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.05),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<BookingBloc>()
                                        .addTIPController
                                        .text = (double.parse(minimumTipAmount)*2).toString();
                                    context.read<BookingBloc>().addTip = double.parse(minimumTipAmount) * 2;
                                  },
                                  child: Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).disabledColor,
                                            width: 1.2),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(6)),
                                    alignment: Alignment.center,
                                    child: MyText(text: '$currencySymbol ${double.parse(minimumTipAmount)*2}'),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.05),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<BookingBloc>()
                                        .addTIPController
                                        .text = (double.parse(minimumTipAmount)*3).toString();
                                    context.read<BookingBloc>().addTip = double.parse(minimumTipAmount)*3;
                                  },
                                  child: Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).disabledColor,
                                            width: 1.2),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(6)),
                                    alignment: Alignment.center,
                                    child: MyText(text: '$currencySymbol ${double.parse(minimumTipAmount)*3}'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.width * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  width: size.width * 0.4,
                                  buttonName:
                                      AppLocalizations.of(context)!.cancel,
                                  isBorder: true,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  textColor: Theme.of(context).primaryColor,
                                  buttonColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                CustomButton(
                                  width: size.width * 0.4,
                                  buttonName:
                                      AppLocalizations.of(context)!.addTip,
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.read<BookingBloc>().add(AddTipsEvent(requestId: requestId,
                                    amount: context.read<BookingBloc>().addTIPController.text));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
