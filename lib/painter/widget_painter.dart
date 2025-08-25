import 'package:arc_item/painter/wedge_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../widgets/widget_card_style.dart';

class WedgePainter extends CustomPainter {
  const WedgePainter({required this.style});
  final WedgeCardStyle style;

  Path _buildPath(Size size) => WedgeClipper(
    radius: style.radius,
    sideInset: style.sideInset,
    curveHeight: style.curveHeight,
    bottomLift: style.bottomLift,
    bottomCornerRadius: style.bottomCornerRadius,
  ).buildPath(size);

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    // 1) Ambient drop shadow of the whole card
    canvas.drawShadow(path, style.shadowColor, 22, false);

    // Clip for inner effects
    canvas.save();
    canvas.clipPath(path);

    // 2) Panel fill (soft vertical gradient)
    final fill = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(0, size.height),
        [style.panelTop, style.panelBottom],
      );
    canvas.drawPath(path, fill);

    // 3) Soft top highlight to avoid a flat look
    final topHighlight = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height * 0.18),
        size.width * 0.85,
        [const Color(0x33FFFFFF), const Color(0x00FFFFFF)],
      );
    canvas.drawRect(Offset.zero & size, topHighlight);

    canvas.restore();

    // 4) Subtle white rim on the actual U path
    final rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = style.rimColor;
    canvas.drawPath(path, rim);
  }

  @override
  bool shouldRepaint(covariant WedgePainter old) => old.style != style;
}