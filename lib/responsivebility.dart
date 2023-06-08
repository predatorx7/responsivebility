library widget_layout;

import 'package:flutter/material.dart';

import 'responsive.dart';

export 'breakpoint/breakpoint.dart';
export 'breakpoint_fitted_box.dart';
export 'responsive.dart';
export 'flex_constraint_box.dart';

typedef GetBreakpointSizeCallback = double Function(
  Size mediaSize,
  VisualDensity visualDensity,
);

class Responsivebility {
  const Responsivebility.of(
    BuildContext context, {
    this.range = const ResponsiveRange.empty(),
    this.breakpointSize,
    this.useTextScaleFactor = true,
  }) : _context = context;

  final BuildContext _context;
  final ResponsiveRange range;
  final GetBreakpointSizeCallback? breakpointSize;
  final bool useTextScaleFactor;

  double size({
    GetBreakpointSizeCallback? breakpointSize,
    ResponsiveRange? range,
    bool? useTextScaleFactor,
  }) {
    final size = MediaQuery.sizeOf(_context);

    final currentSizeCallback = breakpointSize ?? this.breakpointSize;

    double currentSize = currentSizeCallback != null
        ? currentSizeCallback(size, Theme.of(_context).visualDensity)
        : size.width;

    if (useTextScaleFactor ?? this.useTextScaleFactor) {
      final textScaleFactor = MediaQuery.textScaleFactorOf(_context);
      currentSize = currentSize * textScaleFactor;
    }

    final effectiveRange = range ?? this.range;

    final responsiveSize = effectiveRange.computeResponsiveSizeFrom(
      currentSize,
    );

    return responsiveSize;
  }

  T valueOf<T>({
    GetBreakpointSizeCallback? breakpointSize,
    ResponsiveRange? range,
    bool? useTextScaleFactor,
    required T Function(double size) when,
  }) {
    return when(size(
      breakpointSize: breakpointSize,
      range: range,
      useTextScaleFactor: useTextScaleFactor,
    ));
  }
}
