import 'package:flutter/material.dart';
import 'package:major_project__widget_testing/constants/colors.dart';
import 'package:major_project__widget_testing/constants/radius.dart';
import 'package:major_project__widget_testing/utils/scaling.dart';

class CustomToolWidget extends StatefulWidget {
  const CustomToolWidget({
    super.key,
    this.onTap,
    required this.child, required this.message,
  });

  final void Function()? onTap;
  final Widget child;
  final String message;

  @override
  State<CustomToolWidget> createState() => _CustomToolWidgetState();
}

class _CustomToolWidgetState extends State<CustomToolWidget> {
  bool isHover = false;
  bool isClicked = false;
//need to customize the hover and click handles for bold and alignment and bullets acc. to requirement
  void _handleTap() {
    setState(() {
      isClicked = !isClicked;
    });
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  Color? _determineColor() {
    if (isClicked) {
      return grey5.withOpacity(0.2); // Color when clicked
    } else if (isHover) {
      return grey5.withOpacity(0.1); // Color when hovered
    } else {
      return null; // Normal color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: InkWell(
          onTap: _handleTap,
          child: Container(
              height: scaleHeight(context, 37),
              width: scaleHeight(context, 37),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: scaleHeight(context, 7),
                  horizontal: scaleHeight(context, 7)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(rad5_1),
                color: _determineColor(),
              ),
              child: widget.child),
        ),
      ),
    );
  }
}