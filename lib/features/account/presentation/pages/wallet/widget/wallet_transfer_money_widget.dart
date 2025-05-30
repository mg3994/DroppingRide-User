import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/common.dart';
import '../../../../../../core/utils/custom_button.dart';
import '../../../../../../core/utils/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../application/acc_bloc.dart';

class WalletTransferMoneyWidget extends StatelessWidget {
  final BuildContext cont;
    final WalletPageArguments arg;
  const WalletTransferMoneyWidget({super.key, required this.cont, required this.arg});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.05),
                topRight: Radius.circular(size.width * 0.05)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 1,
                blurRadius: 1,
              )
            ]),
        width: size.width,
        child: Container(
          padding: EdgeInsets.fromLTRB(size.width * 0.05, size.width * 0.05,
              size.width * 0.05, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
               Row(
                children: [
                  MyText(
                              text: AppLocalizations.of(context)?.transferMoney ??  "_",textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold), ),
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
              DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor,
                      width: 1.2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.2,
                    style: BorderStyle.solid,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.2,
                    style: BorderStyle.solid,
                  )),
                ),
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                value: context.read<AccBloc>().dropdownValue,
                onChanged: (String? newValue) {
                  context.read<AccBloc>().add(TransferMoneySelectedEvent(
                      selectedTransferAmountMenuItem: newValue!));
                },
                items: context.read<AccBloc>().dropdownItems,
              ),
              TextFormField(
                controller: context.read<AccBloc>().transferAmount,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterAmountHere,
                  counterText: '',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor,
                      width: 1.2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  prefixIcon: SizedBox(
                      height: size.width * 0.1,
                      width: size.width * 0.08,
                      child: Center(
                          child: MyText(text: arg.userData.currencySymbol))),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: size.width * 0.08,
                    maxHeight: size.width * 0.1,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.2,
                    style: BorderStyle.solid,
                  )),
                ),
              ),
              TextFormField(
                controller: context.read<AccBloc>().transferPhonenumber,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterMobileNumber,
                  counterText: '',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.2,
                    style: BorderStyle.solid,
                  )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).disabledColor,
                    width: 1.2,
                    style: BorderStyle.solid,
                  )),
                  prefixIcon: SizedBox(
                      height: size.width * 0.1,
                      width: size.width * 0.08,
                      child: Center(
                          child: MyText(text: arg.userData.countryCode))),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: size.width * 0.08,
                    maxHeight: size.width * 0.1,
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    height: size.width * 0.11,
                    width: size.width * 0.425,
                    buttonName: AppLocalizations.of(context)!.cancel,
                    isBorder : true,
                    buttonColor : Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    ),
                    CustomButton(
                    height: size.width * 0.11,
                      width: size.width * 0.425,
                    buttonName: AppLocalizations.of(context)!.transferMoney,
                    textSize: context.read<AccBloc>().languageCode == 'fr' ? 14 : null,
                    isLoader: context.read<AccBloc>().isLoading,
                    onTap: () {
                      if (context.read<AccBloc>().transferAmount.text == '' ||
                          context.read<AccBloc>().transferPhonenumber.text ==
                              '') {
                      } else {
                        context.read<AccBloc>().add(MoneyTransferedEvent(
                            transferAmount:
                                context.read<AccBloc>().transferAmount.text,
                            role: context.read<AccBloc>().dropdownValue,
                            transferMobile: context
                                .read<AccBloc>()
                                .transferPhonenumber
                                .text));
                      }
                    },
                    ),
                ],
              ),
              SizedBox(height: size.width * 0.05),
            ],
          ),
        ),
      );
    
  }
}