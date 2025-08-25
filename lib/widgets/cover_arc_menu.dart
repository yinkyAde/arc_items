import 'package:arc_item/widgets/widget_card.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../model/arc_tiem.dart';

class CurvedArcMenu extends StatefulWidget {
  const CurvedArcMenu({super.key, required this.items, this.onSelected});

  final List<ArcItem> items;
  final ValueChanged<int>? onSelected;

  @override
  State<CurvedArcMenu> createState() => _CurvedArcMenuState();
}

class _CurvedArcMenuState extends State<CurvedArcMenu>
    with SingleTickerProviderStateMixin {
  late double _position; // fractional index 0..N-1
  late final AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _position = (widget.items.length - 1) / 2; // center the middle item
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    final start = _position;
    _controller
      ..stop()
      ..reset();
    _anim = Tween<double>(begin: start, end: target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    )..addListener(() => setState(() => _position = _anim.value));
    _controller.forward();
  }

  void _snap() {
    final target = _position
        .clamp(0.0, widget.items.length - 1.0)
        .roundToDouble();
    _animateTo(target);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;

        // Arc geometry (tight like the mock)
        final radius = size.height * 1.7;
        final center = Offset(size.width / 2, size.height + radius - 120);
        const baseAngle = -math.pi / 2; // 12 o'clock
        const spread = 0.49; // tiny gutter between cards

        // Card dimensions
        const cardW = 176.0;
        const cardH = 186.0;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (d) =>
              setState(() => _position -= d.primaryDelta! / 180.0),
          onHorizontalDragEnd: (_) => _snap(),
          onTapUp: (_) => _snap(),
          child: SizedBox.expand(
            child: Stack(
              clipBehavior: Clip.none, // allow cards to overflow above
              children: [
                ...List.generate(widget.items.length, (i) {
                  final diff = i - _position;
                  final angle = baseAngle + diff * spread;

                  final x = center.dx + radius * math.cos(angle);
                  final y = center.dy + radius * math.sin(angle);

                  final t = (1 - diff.abs()).clamp(0.0, 1.0);
                  final scale = 0.92 + 0.18 * t; // subtle emphasis on center
                  final opacity = 0.72 + 0.28 * t;
                  final tilt = diff * 0.04; // mild outward tilt

                  return Positioned(
                    left: x - cardW / 2,
                    top: y - cardH * 0.86,
                    width: cardW,
                    height: cardH,
                    child: Opacity(
                      opacity: opacity,
                      child: Transform.rotate(
                        angle: tilt,
                        child: Transform.scale(
                          scale: scale,
                          child: WedgeCard(
                            width: cardW,
                            height: cardH,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // vertical center
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // horizontal center
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: widget.items[i].bg,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(widget.items[i].icon, size: 26),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.items[i].label,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
