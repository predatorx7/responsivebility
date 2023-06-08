import 'breakpoint.dart';

enum BreakpointDip with Breakpoint implements Comparable<Object> {
  dip1200(1200),
  dip1000(1000),
  dip800(800),
  dip600(600),
  dip400(400),
  dip360(360),
  dip320(320),
  dip300(300),
  zero(0);

  const BreakpointDip(this.value);

  @override
  final double value;
}
