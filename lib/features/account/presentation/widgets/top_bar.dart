import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/app_colors.dart';
import '../../application/acc_bloc.dart';
import '../../../../common/app_images.dart';
import '../../../../core/utils/custom_text.dart';

class TopBarDesign extends StatelessWidget {
  final String title;
  final Widget? subTitleWidget;
  final bool isHistoryPage;
  final bool? isOngoingPage;
  final Widget? child;
  final Function()? onTap;
  final ScrollController? controller;
  final Icon? icon;
  final Widget? topCenterWidget;

  const TopBarDesign(
      {super.key,
      this.child,
      required this.isHistoryPage,
      required this.title,
      this.onTap,
      this.isOngoingPage,
      this.subTitleWidget,
      this.controller, this.icon, this.topCenterWidget});
      

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                Container(height: size.height * 0.25),
                if (isHistoryPage) SizedBox(height: size.width * 0.03),
                (isOngoingPage == true)
                    ? Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: child,
                      )
                    : BlocBuilder<AccBloc, AccState>(
                        builder: (context, state) {
                          return Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: child,
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
        ClipPath(
          clipper: ShapePainter(),
          child: Container(
              height: size.width,
              decoration: BoxDecoration(
                color: AppColors.onSecondaryContainerLight,
                image: const DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(AppImages.map),
                ),
              )),
        ),
        SafeArea(
          child: SizedBox(
            height: size.width * 0.37,
            width: size.width,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.08,
                              decoration: const BoxDecoration(
                                color: AppColors.whiteText,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                  onTap: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      if (onTap != null) {
                                        onTap!();
                                      }
                                    });
                                  },
                                  highlightColor: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.1),
                                  splashColor: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.2),
                                  hoverColor: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.05),
                                  child: const Icon(
                                    CupertinoIcons.back,
                                    size: 20,
                                    color: AppColors.blackText,
                                  )),
                            ),
                          ),
                          if (topCenterWidget == null) SizedBox(
                            width: size.width *0.1,
                          ),
                          Row(
                            
                            children: [
                              (topCenterWidget != null) ? topCenterWidget!:
                              Container(
                                decoration: BoxDecoration(
                                   boxShadow: [
          BoxShadow(
            color: Theme.of(context).disabledColor,
            // blurRadius: 0,
            spreadRadius:1.2,
            blurStyle: BlurStyle.solid,
            offset: const Offset(-4, 0),
          ),
        ],
                color:Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),

                                width: size.width * 0.45,
                                height: size.height * 0.051,
                                // color: Colors.red,
                                child: Wrap(
                                  alignment:WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if(icon != null)icon!,
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),  
                                    MyText(
                                     overflow: TextOverflow.clip,
                                      text: title,
                                      maxLines: 1,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 20,
                                                        color: Theme.of(context).primaryColorDark,

                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if(subTitleWidget != null) subTitleWidget!,
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class ShapePainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.675);
    path.quadraticBezierTo(size.width * 0.0, size.height * 0.5,
        size.width * 0.15, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);
    path.quadraticBezierTo(
        size.width, size.height * 0.5, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
