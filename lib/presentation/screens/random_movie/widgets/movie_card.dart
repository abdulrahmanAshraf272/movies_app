import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/data/model/movie.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isBack = true;
  double angle = 0;
  List<Movie> movies = [];
  double val = 0;

  void preloadNextImage() {
    if (movies.isNotEmpty) {
      precacheImage(NetworkImage(movies.first.largeCoverImage!), context);
    }
  }

  void flip() {
    angle = angle == 0 ? pi : 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movies = context.read<MoviesCubit>().allMovies;
    preloadNextImage(); // Ensure the first image is preloaded
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isBack) {
          movies.shuffle();
          preloadNextImage(); // Preload the new image before flipping
        }
        setState(() {
          flip();
        });
      },
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: angle),
          duration: const Duration(seconds: 1),
          builder: (BuildContext context, double val, __) {
            //here we will change the isBack val so we can change the content of the card
            if (val >= (pi / 2)) {
              isBack = false;
            } else {
              isBack = true;
            }
            return (Transform(
                //let's make the card flip by it's center
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(val),
                child: SizedBox(
                  width: 275.w,
                  height: 380.h,
                  child: isBack
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/back.png"),
                            ),
                          ),
                        ) //if it's back we will display here
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateY(
                                pi), // it will flip horizontally the container
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/face.png"),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 265.w,
                                height: 365.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  movies.first.largeCoverImage!,
                                  width: 255.w,
                                  height: 365.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ) //else we will display it here,
                          ),
                )));
          }),
    );
  }
}
