part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class MoviesFetchEvent extends MoviesEvent {}

class MoviesFetchMoreEvent extends MoviesEvent {}
