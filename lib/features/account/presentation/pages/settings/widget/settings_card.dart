import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restart_tagxi/common/app_constants.dart';
import 'package:restart_tagxi/core/utils/custom_card.dart';
import 'package:restart_tagxi/core/utils/custom_text.dart';

class SettingsCard extends StatelessWidget {
    final String optionName;
    final Function()? onTap;
  const SettingsCard({super.key, this.onTap, required this.optionName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
       onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (onTap != null) {
                onTap!();
              }
            });
          },
      child: CustomCard(
        padding:const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [ MyText(
                        text: optionName,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: Theme.of(context).disabledColor,
                                 fontWeight: FontWeight.bold,
                                fontSize: AppConstants().subHeaderSize),
                      ),Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Theme.of(context).disabledColor,
                ),],) ));
  }
}