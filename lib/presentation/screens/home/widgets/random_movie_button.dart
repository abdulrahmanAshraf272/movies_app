import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_colors.dart';

class RandomMovieButton extends StatelessWidget {
  const RandomMovieButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 46,
          width: 46,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            border: Border.all(
              color: AppColors.green.withValues(alpha: 0.5), // Stroke color
              width: 3, // Stroke width
            ),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                blurRadius: 40, // Blur radius
                color: Colors.transparent, // Transparent color for the blur
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/icons/rendom.png',
              width: 28,
            ),
          ),
        ),
      ),
    );
  }
}
