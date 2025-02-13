import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/back_button.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/rate.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/year_and_genre.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh;
    double screenWidth = 1.sw;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.5,
                      width: screenWidth,
                      child: Hero(
                        tag: 'movie_image${movie.id}',
                        child: Image.network(
                          movie.largeCoverImage!,
                          fit: BoxFit.cover,
                          height: screenHeight * 0.5,
                          width: screenWidth,
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.5,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, -4),
                              spreadRadius: 20,
                              blurRadius: 30,
                              color: Colors.black)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Color(0xff19191B)],
                        ),
                      ),
                      child: Column(
                        children: [
                          MovieName(name: movie.title!),
                          YearAndGenre(
                            year: movie.year!,
                            genre: movie.genres!,
                          ),
                          SizedBox(height: 8.h),
                          Rate(rate: movie.rating!.toDouble()),
                          SizedBox(height: 14.h),
                          Expanded(
                              child: MovieSummary(movieSummary: movie.summary!))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 16.h,
                left: 16.w,
                child: const CustomBackButton(),
              ),
            ],
          ),
        ));
  }
}

class MovieName extends StatelessWidget {
  final String name;
  const MovieName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AutoSizeText(
        name,
        maxLines: 1,
        style: TextStyle(
            fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MovieSummary extends StatelessWidget {
  final String movieSummary;
  const MovieSummary({super.key, required this.movieSummary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AutoSizeText(
        movieSummary,
        textAlign: TextAlign.center,
        minFontSize: 12,
        //maxLines: 13,
        style: TextStyle(
            fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.75)),
      ),
    );
  }
}
