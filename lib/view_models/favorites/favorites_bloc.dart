import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesLoadEvent>(_loadFavorites);
    on<FavoritesAddEvent>(_addFavorite);
    on<FavoritesRemoveEvent>(_removeFavorite);
    on<FavoritesRemoveAllEvent>(_clearFavorites);
    // _loadFavorites;
  }

  Future<void> _saveFavorites(List<MovieModel> favoritesList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stringList = favoritesList
        .map(
          (movie) => json.encode(
            movie.toJson(),
          ),
        )
        .toList();
    await prefs.setStringList(MyAppConstants.favoritesKey, stringList);
  }

  // bool _isFavorite(MovieModel movieModel) {
  //   if (state is FavoritesLoadedState) {
  //     return (state as FavoritesLoadedState).favorites.any(
  //           (movie) => movie.id == movieModel.id,
  //         );
  //   }
  //   return false;
  // }

  Future<void> _addFavorite(FavoritesAddEvent event, emit) async {
    if (state is FavoritesInitial) {}
    if (state is FavoritesLoadedState) {
      List<MovieModel> updatedFavorites = List.from((state as FavoritesLoadedState).favorites)..add(event.movieModel);
      emit(FavoritesLoadedState(favorites: updatedFavorites));
      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _removeFavorite(FavoritesRemoveEvent event, emit) async {
    if (state is FavoritesLoadedState) {
      List<MovieModel> updatedFavorites = (state as FavoritesLoadedState).favorites.where((movie) {
        print('${movie.id} ${event.movieModel.id}');
        return movie.id != event.movieModel.id;
      }).toList();
      emit(FavoritesLoadedState(favorites: updatedFavorites));
      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _loadFavorites(event, emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> stringList = prefs.getStringList(MyAppConstants.favoritesKey) ?? [];
    final favoritesMovies = stringList.map((movie) => MovieModel.fromJson(json.decode(movie))).toList();
    emit(FavoritesLoadedState(favorites: favoritesMovies));
  }

  void _clearFavorites(event, emit) async {
    emit(FavoritesLoadedState(favorites: const []));
    await _saveFavorites([]);
  }
}
