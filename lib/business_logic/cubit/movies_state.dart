part of 'movies_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesLoaded extends MoviesState {
  final bool isSearching;
  final List<Movie> movies;
  MoviesLoaded(this.movies, {this.isSearching = false});
}

final class MoviesError extends MoviesState {
  final String errorMessage;
  MoviesError(this.errorMessage);
}
