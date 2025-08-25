import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 22),
    );
  }
}
