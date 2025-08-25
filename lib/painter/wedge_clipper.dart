import 'package:flutter/material.dart';

class WedgeClipper extends CustomClipper<Path> {
  const WedgeClipper({
    required this.radius,
    required this.sideInset,
    required this.curveHeight,
    required this.bottomLift,
    required this.bottomCornerRadius,
  });

  final double radius;             // top corner roundness
  final double sideInset;          // how far sides taper in at the bottom
  final double curveHeight;        // U depth (higher = deeper U)
  final double bottomLift;         // keeps bottom corners slightly above rect bottom
  final double bottomCornerRadius; // small rounding where side meets the U

  Path buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    final r = radius;
    final inset = sideInset;
    final rB = bottomCornerRadius;

    // Corner Y at the sides; center rises by curveHeight (smaller y)
    final cornerY = h - r - bottomLift;
    final midY = h - curveHeight - bottomLift;

    final startX = inset + rB;
    final endX = w - inset - rB;
    final span = endX - startX;

    // Control points for a wide, shallow U (single cubic)
    final cp1x = startX + span * 0.33;
    final cp2x = startX + span * 0.67;

    final p = Path();

    // Top-left rounded corner
    p.moveTo(r, 0);
    p.quadraticBezierTo(0, 0, 0, r);

    // Down the left side to just above the bottom corner
    p.lineTo(inset, cornerY - rB);
    // Small round into the U start — ensures smooth tangent
    p.quadraticBezierTo(inset, cornerY, startX, cornerY);

    // Smooth U bottom (single cubic, no W/kink)
    p.cubicTo(cp1x, midY, cp2x, midY, endX, cornerY);

    // Small round out of the U into the right side
    p.quadraticBezierTo(w - inset, cornerY, w - inset, cornerY - rB);

    // Up the right side and top-right rounded corner
    p.lineTo(w, r);
    p.quadraticBezierTo(w, 0, w - r, 0);

    p.close();
    return p;
  }

  @override
  Path getClip(Size size) => buildPath(size);

  @override
  bool shouldReclip(covariant WedgeClipper old) =>
      old.radius != radius ||
          old.sideInset != sideInset ||
          old.curveHeight != curveHeight ||
          old.bottomLift != bottomLift ||
          old.bottomCornerRadius != bottomCornerRadius;
}