part of 'movies_bloc.dart';

@immutable
sealed class MoviesState extends Equatable {
  const MoviesState();
  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesErroState extends MoviesState {
  final String message;

  MoviesErroState({required this.message});
  @override
  List<Object> get props => [message];
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
  @override
  List<Object> get props => [movies, genres, currentPage];
}

final class MoviesLoadingMoreState extends MoviesState {
  final List<MovieModel> movies;
  final List<MoviesGenre> genres;
  final int currentPage;

  const MoviesLoadingMoreState({
    this.movies = const [],
    this.genres = const [],
    this.currentPage = 0,
  });
  @override
  List<Object> get props => [movies, genres, currentPage];
}
