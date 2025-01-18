part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object> get props => [];
}

class FavoritesLoadEvent extends FavoritesEvent {}

class FavoritesLoaded extends FavoritesEvent {}

class FavoritesAddEvent extends FavoritesEvent {
  final MovieModel movieModel;

  const FavoritesAddEvent({required this.movieModel});
  @override
  List<Object> get props => [movieModel];
}

class FavoritesRemoveEvent extends FavoritesEvent {
  final MovieModel movieModel;

  const FavoritesRemoveEvent({required this.movieModel});
  @override
  List<Object> get props => [movieModel];
}

class FavoritesRemoveAllEvent extends FavoritesEvent {}
