import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/model/movie.dart';
import 'package:movies_app/presentation/routes/route_names.dart';

class MoviesListItem extends StatelessWidget {
  final Movie movie;
  const MoviesListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.movieDetails, arguments: movie);
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Hero(
                  tag: 'movie_image${movie.id}',
                  child: Container(
                    height: constraints.maxHeight * 0.75,
                    width: constraints.maxWidth,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    //color: AppColors.grey,
                    child: movie.largeCoverImage != null &&
                            movie.largeCoverImage!.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: 'assets/images/loading2.gif',
                            image: movie.largeCoverImage!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/movie_image_demo.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.25,
                width: constraints.maxWidth,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          '${movie.title}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white.withValues(alpha: 0.9)),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${movie.year}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white.withValues(alpha: 0.5)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
