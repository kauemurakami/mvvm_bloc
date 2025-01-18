import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<MoviesFetchEvent>(_onFetchMovies);
    on<MoviesFetchMoreEvent>(_onFetchMoreMovies);
  }
  @override
  Future<void> close() async {
    await getIt.unregister<MoviesRepository>();
    return super.close();
  }

  final MoviesRepository _repository = getIt<MoviesRepository>();

  Future<void> _onFetchMovies(event, emit) async {
    emit(MoviesLoadingState());
    try {
      var genres = await _repository.fetchGenres();
      var movies = await _repository.fetchMovies(page: 1);
      emit(
        MoviesLoadedState(
          currentPage: 1,
          genres: genres,
          movies: movies,
        ),
      );
    } catch (e) {
      emit(MoviesErroState(message: 'Failed to load movies $e'));
    }
  }

  Future<void> _onFetchMoreMovies(event, emit) async {
    final currentState = state;
    if (currentState is MoviesLoadingMoreState) return;

    if (currentState is! MoviesLoadedState) return;

    emit(
      MoviesLoadingMoreState(
        currentPage: currentState.currentPage,
        genres: currentState.genres,
        movies: currentState.movies,
      ),
    );
    try {
      List<MovieModel> movies = await _repository.fetchMovies(page: currentState.currentPage + 1);

      if (movies.isEmpty) {
        emit(currentState);
        return;
      }
      currentState.movies.addAll(movies);
      emit(MoviesLoadedState(
        currentPage: currentState.currentPage,
        genres: currentState.genres,
        movies: currentState.movies,
      ));
    } catch (e) {
      emit(MoviesErroState(message: 'Failed to load movies $e'));
    }
  }
}
