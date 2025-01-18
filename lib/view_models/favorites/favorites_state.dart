part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoadingState extends FavoritesState {}

final class FavoritesLoadedState extends FavoritesState {
  final List<MovieModel> favorites;

  const FavoritesLoadedState({required this.favorites});
  @override
  List<Object> get props => [favorites];
}

final class FavoritesErrorState extends FavoritesState {
  final String message;

  const FavoritesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
