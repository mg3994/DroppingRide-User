
import 'package:flutter/material.dart';

class NavigationIconWidget extends StatefulWidget {
  final Widget icon;
  final bool? isShadowWidget;
  final void Function()? onTap;
  final double? height;
  final double? width;
    final Color? color; //Added by MG:
  const NavigationIconWidget({
    super.key,
    required this.icon,
    this.isShadowWidget = false,
    this.onTap,
    this.height,
    this.width,
    this.color,
  });

  @override
  State<NavigationIconWidget> createState() => _NavigationIconWidgetState();
}

class _NavigationIconWidgetState extends State<NavigationIconWidget> {
  bool _isTappedOnce = false;

  void handleTap() {
    if (_isTappedOnce) {
      return;
    } else {
      setState(() {
        _isTappedOnce = true;
      });
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      // onTap: (!_isTappedOnce) ? _handleTap : () {},
      onTap: widget.onTap,
      onTapCancel: () {},
      onDoubleTap: () {},
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: size.width * 0.1,
        width: size.width * 0.1,
        // height: widget.height ?? size.width * 0.1,
        // width: widget.width ?? size.width * 0.1,
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
                        color: widget.color ?? Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                width: 0.5),
                borderRadius: BorderRadius.circular(20),
            boxShadow: widget.isShadowWidget!
                ? [
                    // BoxShadow(
                    //     color: Theme.of(context).shadowColor.withOpacity(0.1),
                    //     spreadRadius: 3,
                    //     blurRadius: 3)
                  ]
                : null),
        child: Center(child: widget.icon),
      ),
    );
  }
}
