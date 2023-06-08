library widget_layout;

import 'package:flutter/widgets.dart';

import 'responsive.dart';

export 'breakpoint/breakpoint.dart';
export 'responsive.dart';
export 'flex_constraint_box.dart';

class WidgetLayout extends StatelessWidget {
  const WidgetLayout({
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
    return builder(context, currentSize, child);
  }
}
