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

  final Map<double, double> valueByRange;

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

double computeResponsiveSizeFrom(
  double currentSize,
  ResponsiveRange range,
) {
  final valueByRange = range.valueByRange;

  assert(valueByRange.isNotEmpty, 'valueByRange must not be empty');

  final values = SplayTreeMap<double, double>.from(valueByRange);
  final ranges = values.keys;
  double begin = ranges.first;
  double end = ranges.last;

  for (final range in ranges) {
    if (currentSize >= range) {
      begin = math.min(begin, range);
    }
    if (currentSize <= range) {
      end = math.max(end, range);
    }
  }

  return Tween(
    begin: values[begin]!,
    end: values[end]!,
  ).transform(
    _getExtrapolationFactor(begin, end, currentSize),
  );
}
