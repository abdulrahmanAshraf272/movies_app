import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/constants/app_colors.dart';
import 'package:movies_app/constants/strings.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/presentation/screens/home/widgets/categories.dart';
import 'package:movies_app/presentation/screens/home/widgets/decoration_light.dart';
import 'package:movies_app/presentation/screens/home/widgets/movies_list_item.dart';
import 'package:movies_app/presentation/screens/home/widgets/movies_search.dart';
import 'package:movies_app/presentation/screens/home/widgets/random_movie_button.dart';
import 'package:movies_app/presentation/screens/home/widgets/top_text_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh;
    double screenWidth = 1.sw;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
              top: -screenHeight * 0.3,
              left: -screenWidth * 0.65,
              child: Hero(
                tag: light1,
                child: DecorationLight(
                  color: AppColors.green,
                ),
              )),
          Positioned(
              top: screenHeight * 0.2,
              right: -screenWidth * 0.75,
              child: Hero(
                tag: light2,
                child: DecorationLight(
                  color: AppColors.pink,
                ),
              )),
          Positioned(
              bottom: -screenHeight * 0.33,
              left: -screenWidth * 0.65,
              child: Hero(
                tag: light3,
                child: DecorationLight(
                  color: AppColors.green,
                ),
              )),
          const Positioned.fill(child: HomeScreenBody())
        ],
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    super.key,
  });

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    super.initState(); // Always call super first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesCubit>().getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const RandomMovieButton(),
        const TopTextHeader(text: 'What would you like to watch?'),
        const MoviesSearch(),
        const Categories(),
        const SizedBox(height: 20),
        Expanded(
          child:
              BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
            if (state is MoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviesError) {
              return MoviesErrorView(
                errorMessage: state.errorMessage,
                onPressedRetry: () => context.read<MoviesCubit>().getMovies(),
              );
            } else if (state is MoviesLoaded) {
              return MoviesLoadedView(movies: state.movies);
            }
            return const SizedBox.shrink();
          }),
        )
      ],
    ));
  }
}

class MoviesErrorView extends StatelessWidget {
  final void Function() onPressedRetry;
  final String errorMessage;
  const MoviesErrorView({
    super.key,
    required this.onPressedRetry,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 50),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onPressedRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

class MoviesLoadedView extends StatelessWidget {
  final List<Movie> movies;
  const MoviesLoadedView({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.5,
        crossAxisSpacing: 25,
        mainAxisSpacing: 1,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MoviesListItem(movie: movies[index]);
      },
    );
  }
}
