library widget_layout;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'responsive.dart';

export 'breakpoint/breakpoint.dart';
export 'responsive.dart';
export 'flex_constraint_box.dart';

class ResponsiveSizeProvider extends StatelessWidget {
  const ResponsiveSizeProvider({
    super.key,
    required this.range,
    this.getCurrentSize,
    this.useTextScaleFactor = true,
    required this.builder,
    this.child,
  });

  final ResponsiveRange range;
  final bool useTextScaleFactor;
  final double Function(Size mediaSize)? getCurrentSize;
  final ValueWidgetBuilder<double> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    double currentSize = getCurrentSize?.call(size) ?? size.shortestSide;

    if (useTextScaleFactor) {
      final textScaleFactor = MediaQuery.textScaleFactorOf(context);
      currentSize = currentSize * textScaleFactor;
    }

    final responsiveSize = range.computeResponsiveSizeFrom(currentSize);

    return builder(context, responsiveSize, child);
  }
}
