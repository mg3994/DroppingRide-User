import 'package:flutter/material.dart';

import 'common.dart';

class DropOffIcon extends StatelessWidget {
  const DropOffIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: AppColors.red.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class DropIcon extends StatelessWidget {
  const DropIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: Icon(
        Icons.location_on_rounded,
        color: AppColors.red,
        size: 23,
      ),
    );
  }
}

