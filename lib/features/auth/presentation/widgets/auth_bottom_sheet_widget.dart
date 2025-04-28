import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restart_tagxi/core/utils/custom_card.dart';

import '../../../../common/common.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/custom_loader.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../../core/utils/custom_textfield.dart';
import '../../../../core/utils/functions.dart';
import '../../../../l10n/app_localizations.dart';

class AuthBottomSheetWidget extends StatefulWidget {
  final TextEditingController emailOrMobile;
  final dynamic continueFunc;
  final bool showLoginBtn;
  final bool isLoginByEmail;
  final Function()? onTapEvent;
  final Function(String)? onChangeEvent;
  final Function(String)? onSubmitEvent;
  final Function()? countrySelectFunc;
  final GlobalKey<FormState> formKey;
  final String dialCode;
  final String flagImage;
  final FocusNode focusNode;
  final bool isShowLoader;
  const AuthBottomSheetWidget(
      {super.key,
      required this.emailOrMobile,
      required this.continueFunc,
      required this.showLoginBtn,
      required this.isLoginByEmail,
      this.onTapEvent,
      this.onChangeEvent,
      this.onSubmitEvent,
      required this.formKey,
      required this.dialCode,
      required this.flagImage,
      this.countrySelectFunc,
      required this.focusNode,
      required this.isShowLoader});

  @override
  State<StatefulWidget> createState() => AuthBottomSheetWidgetState();
}

class AuthBottomSheetWidgetState extends State<AuthBottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continuePressed() {
    _controller.forward();
  }

  _closeDialog() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: <Widget>[
            // Container(
               CustomCard(
                  borderRadius: 2,
                  border: Border.all(width: 0.4,color:Theme.of(context).disabledColor.withAlpha(100)),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(1),
              // height: widget.showLoginBtn ? size.height * 0.38 : size.height * 0.25,
              // decoration: BoxDecoration(
              //   color: Theme.of(context).scaffoldBackgroundColor,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Theme.of(context).shadowColor,
              //       blurRadius: 5,
              //       spreadRadius: 1,
              //     )
              //   ],
              //   borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText(
                          text:
                              '${AppLocalizations.of(context)!.welcome}, ${AppLocalizations.of(context)!.user}',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: AppConstants().subHeaderSize),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(AppImages.hi, height: 20, width: 25)
                      ],
                    ),
                    SizedBox(height: size.width * 0.03),
                     DottedLine(
                          // ADDED: BY MG: Dotted line
                          dashLength: 2,
                          dashGapLength: 2,
                          dashRadius: 1,
                          lineThickness: 1,
                          dashColor: Theme.of(context).dividerColor,
                        ),
                        SizedBox(height: size.width * 0.04),
                    MyText(
                      text:
                          // '${AppLocalizations.of(context)!.email}/'
                          '${AppLocalizations.of(context)!.mobileNumber}',
                      textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                            // color: AppColors.darkGrey,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Form(
                      key: widget.formKey,
                      child: CustomTextField(
                        style:
                                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    ), 
                         contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            borderRadius: 4,
                        controller: widget.emailOrMobile,
                        filled: true,
                        focusNode: widget.focusNode,
                        hintText: AppLocalizations.of(context)!
                            .enterMobileNumber,
                        prefixConstraints:
                            BoxConstraints(maxWidth: size.width * 0.2),
                        prefixIcon: 
                        // !widget.isLoginByEmail
                        //     ? 
                            Center(
                                child: InkWell(
                                  onTap: widget.countrySelectFunc,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 22,
                                        width: 28,
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: BorderRadius.circular(1),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.flagImage,
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
                                      MyText(
                                        text: widget.dialCode,
                                        textStyle:
                                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    ), // Modified By MG:
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            // : null
                            ,
                            keyboardType:
                            //  widget.isLoginByEmail
                                // ? TextInputType.emailAddress
                                // :
                                 TextInputType.phone,
                        onTap: widget.onTapEvent,
                        onSubmitted: widget.onSubmitEvent,
                        onChange: widget.onChangeEvent,
                        validator: (value) {
                          if (value!.isNotEmpty &&
                              !AppValidation.emailValidate(value) 
                              &&
                              !AppValidation.mobileNumberValidate(value)) {
                            return AppLocalizations.of(context)?.validMobile;
                          } else if (value.isEmpty) {
                            return AppLocalizations.of(context)?.validMobile;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    // if (widget.showLoginBtn) ...[
                    SizedBox(height: size.width * 0.05),
                    // Center(
                    //   child: CustomButton(
                    //     buttonName: AppLocalizations.of(context)!.continueN,
                    //     borderRadius: 18,
                    //     width: size.width,
                    //     height: size.width * 0.12,
                    //     textColor: AppColors.white,
                    //     buttonColor: (widget.emailOrMobile.text.isEmpty)
                    //         ? Theme.of(context).disabledColor.withOpacity(0.5)
                    //         : null,
                    //     onTap: () {
                    //       if (widget.formKey.currentState!.validate() &&
                    //           widget.emailOrMobile.text.isNotEmpty) {
                    //         FocusScope.of(context).requestFocus(FocusNode());
                    //         _continuePressed();
                    //       }
                    //     },
                    //   ),
                    // ),
                    
                    // ],
                  ],
                ),
              ),
            ),
            
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Theme.of(context).dialogBackgroundColor,
                            shape: RoundedRectangleBorder(
                               side: BorderSide(width: 1.2,color:Theme.of(context).disabledColor.withAlpha(100),),
                                borderRadius: BorderRadius.circular(2))),
                        child: 
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 25, vertical: 20),
                        //   child:
                           Column(
                            spacing: 4,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 25), // TODO: Make It Dynamic MG:
                              Wrap(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  alignment : WrapAlignment.center,
                                  children: [
                                    if(!widget.isLoginByEmail) ...[
                                    CachedNetworkImage(
                                      imageUrl: widget.flagImage,
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
                                    SizedBox(width: size.width * 0.02),
                                    MyText(
                                      text: widget.dialCode,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          // .copyWith(fontSize: 20),
                                    ),
                                  ],
                                    SizedBox(width: size.width * 0.02),
                                    MyText(
                                      text: widget.emailOrMobile.text,
                                      maxLines: 3,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          // .copyWith(fontSize: 20)
                                          ,
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).shadowColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                // margin: const EdgeInsets.symmetric(horizontal: 4),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.23, vertical: 15),

                               
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        style: Theme.of(context).textTheme.bodyMedium,
                                        text:
                                            '${AppLocalizations.of(context)!.isThisCorrect} ',
                                      ),
                                      TextSpan(
                                        style: AppTextStyle.boldStyle(
                                          size: 16,
                                          weight: FontWeight.normal,
                                        ).copyWith(
                                            color: (Theme.of(context).brightness ==
                                                    Brightness.light)
                                                ? AppColors.black
                                                : AppColors.white,
                                            decoration: TextDecoration.underline,
                                                  fontWeight: FontWeight.w600, // Added: By MG:
                                            decorationStyle:
                                                TextDecorationStyle.solid),
                                        text: AppLocalizations.of(context)!.edit,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _closeDialog,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // CustomButton(
                              //   buttonName: AppLocalizations.of(context)!.continueN,
                              //   borderRadius: 18,
                              //   width: size.width,
                              //   height: size.width * 0.12,
                              //   isLoader: widget.isShowLoader,
                              //   onTap: widget.continueFunc,
                              // )
                            ],
                          ),
                        // ),
                      ),
                    ),
                  ),
                );
              },
            ),
            
          ],
        ),
         SizedBox(height: size.width * 0.05),
        Center(
          child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (context, value, child) {
                return CustomButton(
                  buttonName: (_controller.status == AnimationStatus.completed)
                      ? AppLocalizations.of(context)!.confirm
                      : AppLocalizations.of(context)!.continueN,
                  // buttonName: AppLocalizations.of(context)!.continueText,
                  borderRadius: 4,
                  width: size.width * 0.88,
                  height: size.width * 0.12,
                  // textColor: AppColors.white,
                  buttonColor: (widget.emailOrMobile.text.isEmpty)
                      ? Theme.of(context).disabledColor.withOpacity(0.5)
                      : null,
                  isLoader: widget.isShowLoader,
                  onTap: () {
                    if (widget.formKey.currentState!.validate() &&
                        widget.emailOrMobile.text.isNotEmpty) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // _continuePressed();
                      if (_controller.status == AnimationStatus.completed) {
                        widget.continueFunc();
                      } else {
                        _continuePressed();
                      }
                    }
                  },
                );
              }),
        ),
        SizedBox(height: size.width * 0.02),
                SizedBox(
                  width: size.width,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      MyText(
                        text: '${AppLocalizations.of(context)!.byContinuing} ',
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(
                                // color: AppColors.darkGrey,
                                fontWeight: FontWeight.normal),
                      ),
                      InkWell(
                        onTap: () async {
                          openUrl(AppConstants.termsCondition);
                        },
                        child: MyText(
                          text: '${AppLocalizations.of(context)!.terms} ',
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).primaryColorDark,
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                      MyText(
                        text: "${AppLocalizations.of(context)!.and} ",
                        textStyle:
                            Theme.of(context).textTheme.labelSmall!.copyWith(
                                  // color: AppColors.darkGrey,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                      InkWell(
                        onTap: () async {
                          openUrl(AppConstants.privacyPolicy);
                        },
                        child: MyText(
                          text:
                              '${AppLocalizations.of(context)!.privacyPolicy} ',
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                   color: Theme.of(context).primaryColorDark,
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
      ],
    );
  }
}
