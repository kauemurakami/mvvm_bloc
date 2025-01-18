part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object> get props => [];
}

class MoviesFetchEvent extends MoviesEvent {}

class MoviesFetchMoreEvent extends MoviesEvent {}
