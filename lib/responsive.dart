import 'dart:collection';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/animation.dart' show Tween;

import 'breakpoint/breakpoint.dart';

const _unorderedEquality = DeepCollectionEquality.unordered();

class ResponsiveRange {
  const ResponsiveRange(this.valueByRange);

  ResponsiveRange.fromBreakpoints(Map<Breakpoint, double> valueByBreakpoint)
      : valueByRange = valueByBreakpoint.map(
          (key, value) => MapEntry(key.value, value),
        );

  const ResponsiveRange.empty() : valueByRange = const {};

  final Map<double, double> valueByRange;

  double computeResponsiveSizeFrom(
    double size,
  ) {
    final values = SplayTreeMap<double, double>.from(valueByRange);
    final ranges = values.keys;
    double begin = ranges.first;
    double end = ranges.last;

    for (final range in ranges) {
      if (size >= range) {
        begin = math.min(begin, range);
      }
      if (size <= range) {
        end = math.max(end, range);
      }
    }

    return Tween(
      begin: values[begin]!,
      end: values[end]!,
    ).transform(
      _getExtrapolationFactor(begin, end, size),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ResponsiveRange &&
        _unorderedEquality.equals(
          other.valueByRange,
          valueByRange,
        );
  }

  @override
  int get hashCode => valueByRange.hashCode;
}

double _getExtrapolationFactor(num a, num b, double x) {
  return (x.clamp(a, b) - a) / (b - a);
}
