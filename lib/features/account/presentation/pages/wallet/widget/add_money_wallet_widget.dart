import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/common.dart';
import '../../../../../../core/utils/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../application/acc_bloc.dart';

class AddMoneyWalletWidget extends StatelessWidget {
  final BuildContext cont;
  final String minWalletAmount;
  const AddMoneyWalletWidget({super.key, required this.cont, required this.minWalletAmount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(value: cont.read<AccBloc>(),
    child: BlocBuilder<AccBloc,AccState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 1,
                blurRadius: 1,
              )
            ]),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  MyText(
                              text: AppLocalizations.of(context)?.addMoney ??  "_",textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold), ),
                ],
              ),
                    const SizedBox(height: 4,),
                    DottedLine( // ADDED: BY MG: Dotted line
                                dashLength: 2,
                                dashGapLength: 2,
                                dashRadius: 1,
                                lineThickness: 1,
                                dashColor: Theme.of(context).dividerColor,
                              ),
                    const SizedBox(height: 10,),


              Container(
                height: size.width * 0.128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      width: 1.2, color: Theme.of(context).disabledColor),
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
                        color: Theme.of(context).disabledColor.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: MyText(
                          text: context
                              .read<AccBloc>()
                              .walletResponse
                              ?.currencySymbol ??  "_" ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Container(
                      height: size.width * 0.128,
                      width: size.width * 0.6,
                      alignment: Alignment.center,
                      child: TextField(
                        controller:
                            context.read<AccBloc>().walletAmountController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context.read<AccBloc>().addMoney = int.parse(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context)!.enterAmountHere,
                          hintStyle: const TextStyle(fontSize: 14),
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<AccBloc>().walletAmountController.text =
                          double.parse(minWalletAmount).toString();
                      context.read<AccBloc>().addMoney = double.parse(minWalletAmount);
                    },
                    child: Container(
                      height: size.width * 0.11,
                      width: size.width * 0.17,
                      // width: size.width *
                      //     0.275,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).disabledColor,
                              width: 1.2),
                          color: Theme.of(context).dividerColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: MyText(
                          text:
                              '${context.read<AccBloc>().walletResponse!.currencySymbol.toString()}${double.parse(minWalletAmount)}'),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<AccBloc>().walletAmountController.text =
                          (double.parse(minWalletAmount) *2).toString();
                      context.read<AccBloc>().addMoney = double.parse(minWalletAmount) * 2;
                    },
                    child: Container(
                      height: size.width * 0.11,
                      width: size.width * 0.17,
                      decoration: BoxDecoration(
                        // color:Theme.of(context).canvasColor,
                          border: Border.all(
                              color: Theme.of(context).disabledColor,
                              width: 1.2),
                          color: Theme.of(context).dividerColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: MyText(
                          text:
                              '${context.read<AccBloc>().walletResponse!.currencySymbol.toString()}${double.parse(minWalletAmount) * 2}'),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      context.read<AccBloc>().walletAmountController.text =
                          (double.parse(minWalletAmount) * 3).toString();
                      context.read<AccBloc>().addMoney = double.parse(minWalletAmount) * 3;
                    },
                    child: Container(
                      height: size.width * 0.11,
                      width: size.width * 0.17,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).disabledColor,
                              width: 1.2),
                         color: Theme.of(context).dividerColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: MyText(
                          text:
                              '${context.read<AccBloc>().walletResponse!.currencySymbol.toString()}${double.parse(minWalletAmount) * 3}'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.width * 0.025),

                    DottedLine( // ADDED: BY MG: Dotted line
                                dashLength: 2,
                                dashGapLength: 2,
                                dashRadius: 1,
                                lineThickness: 1,
                                lineLength: size.width * 0.7,
                                dashColor: Theme.of(context).dividerColor,
                              ),
              SizedBox(height: size.width * 0.025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: size.width * 0.11,
                      width: size.width * 0.425,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (Theme.of(context).brightness ==
                                      Brightness.light)
                                  ? Theme.of(context).primaryColor
                                  : AppColors.white,
                              width: 1.2),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: MyText(
                        text: AppLocalizations.of(context)!.cancel,
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light)
                                      ? Theme.of(context).primaryColor
                                      : AppColors.white,
                                ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (context
                              .read<AccBloc>()
                              .walletAmountController
                              .text
                              .isNotEmpty &&
                          context.read<AccBloc>().addMoney != null) {
                        Navigator.pop(context);
                        context.read<AccBloc>().add(ShowPaymentGatewayEvent());
                      }
                    },
                    child: Container(
                      height: size.width * 0.11,
                      width: size.width * 0.425,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: MyText(
                        text: AppLocalizations.of(context)!.addMoney,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.width * 0.05),
            ],
          ),
        ),
      );
    },)
    );
  }
}