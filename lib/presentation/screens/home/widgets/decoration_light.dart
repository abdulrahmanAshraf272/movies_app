import 'package:flutter/material.dart';

class DecorationLight extends StatelessWidget {
  final Color color;
  const DecorationLight({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClipOval(
      child: Container(
        width: screenWidth * 1.4,
        height: screenWidth * 1.4,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            colors: [
              color.withValues(alpha: 0.5),
              Colors.transparent,
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: screenWidth * 1.4, // Layer blur
              color: Colors.transparent, // Transparent color for the blur
            ),
          ],
        ),
      ),
    );
  }
}
