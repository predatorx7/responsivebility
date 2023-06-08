import 'package:meta/meta.dart';
import 'breakpoint.dart';

@protected
class BreakpointValue with Breakpoint implements Comparable<Object> {
  const BreakpointValue(this.value);

  @override
  final double value;

  @override
  bool operator ==(Object other) {
    return (other is num && value == other) ||
        (other is Breakpoint && value == other.value);
  }

  @override
  int get hashCode => value.hashCode;
}
