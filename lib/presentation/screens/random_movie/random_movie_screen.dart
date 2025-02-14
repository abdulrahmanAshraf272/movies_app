import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants/app_colors.dart';
import 'package:movies_app/constants/strings.dart';
import 'package:movies_app/presentation/screens/home/widgets/decoration_light.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/back_button.dart';
import 'package:movies_app/presentation/screens/random_movie/widgets/movie_card.dart';

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
          const Positioned.fill(child: RandomMovieBody()),
          const Positioned(
              top: 0, left: 16, child: SafeArea(child: CustomBackButton())),
        ],
      ),
    );
  }
}

class RandomMovieBody extends StatelessWidget {
  const RandomMovieBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Are you confused what to watch?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'click on the card!',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7), fontSize: 18.sp),
          ),
          const SizedBox(height: 20),
          const MovieCard()
        ],
      ),
    ));
  }
}
