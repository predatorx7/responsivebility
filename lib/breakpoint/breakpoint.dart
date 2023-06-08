import 'breakpoint_value.dart';

export 'breakpoint_value.dart';
export 'breakpoint_dip.dart';

abstract mixin class Breakpoint {
  double get value;

  const factory Breakpoint(double value) = BreakpointValue;

  int compareTo(Object other) {
    if (other is num) {
      return value.compareTo(other);
    } else if (other is Breakpoint) {
      return value.compareTo(other.value);
    } else {
      return -1;
    }
  }

  bool operator <(Object other) {
    return (other is num && value < other) ||
        (other is Breakpoint && value < other.value);
  }

  bool operator >(Object other) {
    return (other is num && value > other) ||
        (other is Breakpoint && value > other.value);
  }

  bool operator >=(Object other) {
    return (other is num && value >= other) ||
        (other is Breakpoint && value >= other.value);
  }

  bool operator <=(Object other) {
    return (other is num && value <= other) ||
        (other is Breakpoint && value <= other.value);
  }

  @override
  String toString() {
    return 'Breakpoint($value)';
  }

  static Breakpoint min(Breakpoint a, Breakpoint b) {
    if (a < b) return a;
    return b;
  }

  static Breakpoint max(Breakpoint a, Breakpoint b) {
    if (a > b) return a;
    return b;
  }
}
