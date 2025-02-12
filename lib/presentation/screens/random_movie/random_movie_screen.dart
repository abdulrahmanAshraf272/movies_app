import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants/app_colors.dart';
import 'package:movies_app/constants/strings.dart';
import 'package:movies_app/presentation/screens/home/widgets/decoration_light.dart';

class RandomMovieScreen extends StatelessWidget {
  const RandomMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh;
    double screenWidth = 1.sw;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
              top: screenHeight * 0.2,
              left: -screenWidth * 0.85,
              child: Hero(
                tag: light1,
                child: DecorationLight(
                  color: AppColors.green,
                ),
              )),
          Positioned(
              top: -screenHeight * 0.2,
              right: -screenWidth * 0.75,
              child: Hero(
                tag: light2,
                child: DecorationLight(
                  color: AppColors.pink,
                ),
              )),
          Positioned(
              bottom: -screenHeight * 0.33,
              right: -screenWidth * 0.65,
              child: Hero(
                tag: light3,
                child: DecorationLight(
                  color: AppColors.green,
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
