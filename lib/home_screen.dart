import 'package:arc_item/widgets/cover_arc_menu.dart';
import 'package:flutter/material.dart';

import 'widgets/circle_icon.dart';
import 'model/arc_tiem.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <ArcItem>[
      ArcItem(
        icon: Icons.open_in_new_rounded,
        label: 'Convert',
        bg: const Color(0xFFEADFF2),
      ),
      ArcItem(
        icon: Icons.document_scanner_rounded,
        label: 'Scan',
        bg: const Color(0xFFDFF2F4),
      ),
      ArcItem(
        icon: Icons.face_retouching_natural_rounded,
        label: 'Edit',
        bg: const Color(0xFFF3E6C9),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1EFE9), Color(0xFFF5D2A6)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                left: 16,
                top: 8,
                child: CircleIcon(icon: Icons.help_outline_rounded),
              ),
              const Positioned(
                right: 16,
                top: 8,
                child: CircleIcon(icon: Icons.person_outline_rounded),
              ),

              Align(
                alignment: const Alignment(0, -0.15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Hi Peter,',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 44,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'How can i help\nyou today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 44,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: SizedBox(
                    height: 272, // headroom so the top never gets cut
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none, // allow upward overflow
                      alignment: Alignment.bottomCenter,
                      children: [
                        CurvedArcMenu(items: items, onSelected: (i) {}),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 24,
                                  offset: Offset(0, 8),
                                  color: Color(0x33000000),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
