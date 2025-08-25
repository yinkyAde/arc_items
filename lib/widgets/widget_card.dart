import 'package:arc_item/widgets/widget_card_style.dart';
import 'package:flutter/material.dart';

import '../painter/wedge_clipper.dart';
import '../painter/widget_painter.dart';

class WedgeCard extends StatelessWidget {
  const WedgeCard({
    super.key,
    required this.width,
    required this.height,
    this.child,
    this.style = const WedgeCardStyle(),
  });

  final double width;
  final double height;
  final Widget? child;
  final WedgeCardStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: Size(width, height), painter: WedgePainter(style: style)),
          ClipPath(
            clipper: WedgeClipper(
              radius: style.radius,
              sideInset: style.sideInset,
              curveHeight: style.curveHeight,
              bottomLift: style.bottomLift,
              bottomCornerRadius: style.bottomCornerRadius,
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              color: Colors.transparent,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}