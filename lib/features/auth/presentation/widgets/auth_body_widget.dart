import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common.dart';
import '../../../../core/utils/custom_background.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../language/presentation/page/choose_language_page.dart';
import '../../application/auth_bloc.dart';

class AuthBodyWidget extends StatelessWidget {
  final BuildContext cont;
   final List<Widget>? children;

  const AuthBodyWidget({super.key, required this.cont, this.children});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider.value(value: cont.read<AuthBloc>(),
    child: BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
      return 
      // CustomBackground(child: 
      SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [                  
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ChooseLanguagePage.routeName,
                          arguments: ChooseLanguageArguments(
                              isInitialLanguageChange: false),
                        ).then(
                          (value) {
                            if (!context.mounted) return;
                            context.read<AuthBloc>().add(GetDirectionEvent());
                          },
                        );
                      },
                      child: Row(
                        children: [
                          MyText(
                              text: context.read<AuthBloc>().languageCode.toUpperCase(),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      // color: Theme.of(context).primaryColor
                                      )),
                          const Icon(Icons.language_outlined,
                              // color: Theme.of(context).primaryColor
                              ),
                          const Icon(Icons.arrow_drop_down,
                              // color: Theme.of(context).primaryColor
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
              child: Center(
                child: CarouselSlider(
                  items: context.read<AuthBloc>().splashImages,
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(milliseconds: 300),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            Column(
              children: children ?? [],
            ),
          ],
        ),
      )
      // ,
    // )
    ;
  
    },),);
  }
}