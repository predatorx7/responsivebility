import 'package:flutter/material.dart';

const flexDefaultConstraint = BoxConstraints(maxWidth: 800);

class FlexConstraintBox extends StatelessWidget {
  final Axis direction;
  final Widget child;
  final BoxConstraints constraints;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;

  const FlexConstraintBox({
    super.key,
    this.direction = Axis.horizontal,
    required this.child,
    this.constraints = flexDefaultConstraint,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.textBaseline,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textBaseline: textBaseline,
      textDirection: textDirection,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: constraints,
            child: child,
          ),
        ),
      ],
    );
  }
}
