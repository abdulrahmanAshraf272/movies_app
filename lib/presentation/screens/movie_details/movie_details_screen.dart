import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants/app_colors.dart';
import 'package:movies_app/presentation/screens/home/widgets/decoration_light.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh;
    double screenWidth = 1.sw;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          //BackgroundDecorations(),
          Positioned(
              top: screenHeight * 0.70,
              right: -screenWidth * 0.75,
              child: Hero(
                tag: 1,
                child: DecorationLight(
                  color: AppColors.pink,
                ),
              )),
          Positioned.fill(
              child: Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('click'),
            ),
          ))
        ],
      ),
    );
  }
}
