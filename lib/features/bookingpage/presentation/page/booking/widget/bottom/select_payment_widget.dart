import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_tagxi/core/utils/custom_snack_bar.dart';
import 'package:restart_tagxi/l10n/app_localizations.dart';

import '../../../../../../../core/utils/custom_text.dart';
import '../../../../../application/booking_bloc.dart';

class SelectPaymentMethodWidget extends StatelessWidget {
  final BuildContext cont;
  const SelectPaymentMethodWidget({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(
      value: cont.read<BookingBloc>(),
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          return Container(
            width: size.width,
            height: size.width * 0.7,
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: AppLocalizations.of(context)!.choosePayment,
                      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                          DottedLine( // ADDED: BY MG: Dotted line
                                  dashLength: 2,
                                  dashGapLength: 2,
                                  dashRadius: 1,
                                  lineThickness: 1,
                                  dashColor: Theme.of(context).dividerColor,
                                ),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                            context.read<BookingBloc>().paymentList.length,
                            (index) {
                          return Theme(
                            data: ThemeData(
                              unselectedWidgetColor:
                                  Theme.of(context).primaryColorDark,
                            ),
                            child: RadioListTile(
                              tileColor: Theme.of(context).shadowColor.withOpacity(0.3),
                              value: context
                                  .read<BookingBloc>()
                                  .paymentList[index],
                              groupValue: context
                                  .read<BookingBloc>()
                                  .selectedPaymentType,
                              onChanged: (value) {
                                
                                    if (value.toString() == 'wallet') {
                                      if (context
                                                  .read<BookingBloc>()
                                                  .paymentList[index] ==
                                              'wallet' &&
                                          context
                                                  .read<BookingBloc>()
                                                  .userData!
                                                  .wallet
                                                  .data
                                                  .amountBalance >
                                              context
                                                  .read<BookingBloc>()
                                                  .selectedEtaAmount) {
                                        context
                                                .read<BookingBloc>()
                                                .selectedPaymentType =
                                            value.toString();
                                        context
                                            .read<BookingBloc>()
                                            .add(UpdateEvent());
                                        Navigator.pop(context);
                                      } else {
                                        showToast(
                                            message: 'Low wallet balance');
                                      }
                                    } else {
                                      context
                                              .read<BookingBloc>()
                                              .selectedPaymentType =
                                          value.toString();
                                      context
                                          .read<BookingBloc>()
                                          .add(UpdateEvent());
                                      Navigator.pop(context);
                                    }
                              },
                              activeColor: Theme.of(context).primaryColorDark,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Row(
                                children: [
                                  Icon(
                                      context
                                                  .read<BookingBloc>()
                                                  .paymentList[index] ==
                                              'cash'
                                          ? Icons.payments_outlined
                                          : (context
                                                          .read<BookingBloc>()
                                                          .paymentList[index] ==
                                                      'card' ||
                                                  context
                                                          .read<BookingBloc>()
                                                          .paymentList[index] ==
                                                      'onlne')
                                              ? Icons.credit_card_rounded
                                              : Icons
                                                  .account_balance_wallet_outlined,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  SizedBox(width: size.width * 0.05),
                                  MyText(
                                    text: context
                                        .read<BookingBloc>()
                                        .paymentList[index],
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle: (context
                                          .read<BookingBloc>()
                                          .paymentList[index] ==
                                      'wallet')
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.1),
                                      child: MyText(
                                        text:
                                            '${context.read<BookingBloc>().userData!.wallet.data.currencySymbol} ${context.read<BookingBloc>().userData!.wallet.data.amountBalance}',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
