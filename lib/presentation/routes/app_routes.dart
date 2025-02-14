import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/data/repository/movies_repository.dart';
import 'package:movies_app/data/web_services/movies_web_services.dart';
import 'package:movies_app/presentation/routes/route_names.dart';
import 'package:movies_app/presentation/screens/home/home_screen.dart';
import 'package:movies_app/presentation/screens/movie_details/movie_details_screen.dart';
import 'package:movies_app/presentation/screens/random_movie/random_movie_screen.dart';

class AppRoutes {
  late MoviesRepository moviesRepository;
  late MoviesCubit moviesCubit;
  AppRoutes() {
    moviesRepository = MoviesRepository(MoviesWebServices());
    moviesCubit = MoviesCubit(moviesRepository);
  }
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: moviesCubit,
            child: const HomeScreen(),
          ),
        );

      case RouteNames.movieDetails:
        final argument = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
            movie: argument,
          ),
        );

      case RouteNames.randomMovie:
        // return PageRouteBuilder(
        //   settings: settings,
        //   pageBuilder: (context, animation, secondaryAnimation) =>
        //       BlocProvider.value(
        //     value: moviesCubit,
        //     child: const RandomMovieScreen(),
        //   ),

        //   transitionDuration:
        //       const Duration(milliseconds: 1000), // Slow transition
        // );
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: moviesCubit,
            child: const RandomMovieScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
