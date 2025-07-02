import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidBottomNavBar extends StatefulWidget {
  const LiquidBottomNavBar({super.key});

  @override
  State<LiquidBottomNavBar> createState() => _LiquidBottomNavBarState();
}

class _LiquidBottomNavBarState extends State<LiquidBottomNavBar> {
  int _currentIndex = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25, right: 20, left: 20),
      child: LiquidGlass(
        glassContainsChild: false,
        settings: const LiquidGlassSettings(
            ambientStrength: 2,
            lightAngle: 0.4 * math.pi,
            glassColor: Colors.black12,
            thickness: 30,
            blur: 4),
        // settings: const LiquidGlassSettings(
        //   ambientStrength: 0.5,
        //   lightAngle: 0.2 * math.pi,
        //   glassColor: Colors.white12,
        //   blur: 3,
        // ),
        shape: const LiquidRoundedRectangle(borderRadius: Radius.circular(100)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_icons.length, (index) {
              final isSelected = _currentIndex == index;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _currentIndex = index),
                  child: SizedBox(
                    height: 70,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedScale(
                          scale: isSelected ? 1 : 0.3,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: isSelected
                                  ? Colors.grey.withValues(alpha: 0.4)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        Icon(
                          _icons[index],
                          size: 28,
                          color: isSelected ? Colors.red : Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
