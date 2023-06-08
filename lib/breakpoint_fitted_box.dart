import 'package:flutter/material.dart';

class BreakpointFittedBox extends StatelessWidget {
  const BreakpointFittedBox({
    super.key,
    required this.breakpointScaleFactor,
    required this.breakpointWidth,
    required this.child,
  });

  final Widget child;
  final double breakpointWidth;
  final double breakpointScaleFactor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textScalingFactor = MediaQuery.textScaleFactorOf(context);
    final width = size.width * textScalingFactor;

    Widget child = this.child;

    if (width < (breakpointWidth * textScalingFactor)) {
      child = SizedBox(
        width: width * breakpointScaleFactor,
        child: FittedBox(
          fit: BoxFit.contain,
          child: child,
        ),
      );
    }

    return child;
  }
}
