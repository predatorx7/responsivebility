import 'package:flutter_test/flutter_test.dart';
import 'package:responsivebility/responsivebility.dart';

void main() {
  group('ResponsiveRange', () {
    test('compute responsive size', () {
      expect(
        ResponsiveRange({
          500: 200,
          1000: 300,
        }).computeResponsiveSizeFrom(750),
        equals(250),
      );

      expect(
        ResponsiveRange({
          0: 200,
          1000: 300,
        }).computeResponsiveSizeFrom(500),
        equals(250),
      );

      expect(
        ResponsiveRange({
          500: 0,
          1000: 300,
        }).computeResponsiveSizeFrom(750),
        equals(150),
      );
    });
  });
}
