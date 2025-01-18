part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesErroState extends MoviesState {
  final String message;

  MoviesErroState({required this.message});
}

final class MoviesLoadingState extends MoviesState {}

final class MoviesLoadedState extends MoviesState {
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  MoviesLoadedState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 1,
  });
}

final class MoviesLoadingMoreState extends MoviesState {
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  MoviesLoadingMoreState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 0,
  });
}
