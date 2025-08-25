import 'package:flutter/material.dart';

class WedgeCardStyle {
  const WedgeCardStyle({
    this.radius = 26.0,                 // softer top corners
    this.sideInset = 10.0,              // slight inward taper of sides
    this.curveHeight = 36.0,            // U depth (higher = deeper U)
    this.bottomLift = 4.0,              // lifts bottom corners slightly
    this.bottomCornerRadius = 8.0,      // small rounding where sides meet the U
    this.panelTop = const Color(0xFFFEFCF8),
    this.panelBottom = const Color(0xFFF1E5D3),
    this.rimColor = const Color(0x7FFFFFFF),
    this.shadowColor = const Color(0x1A000000),
  });

  final double radius;
  final double sideInset;
  final double curveHeight;     // controls how shallow/deep the U is
  final double bottomLift;
  final double bottomCornerRadius;
  final Color panelTop;
  final Color panelBottom;
  final Color rimColor;
  final Color shadowColor;
}