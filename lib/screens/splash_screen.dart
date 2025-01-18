import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_bloc.dart';

import '../widgets/my_error_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MoviesBloc, MoviesState>(
            listener: (context, state) {
              if (state is MoviesLoadedState && context.read<FavoritesBloc>().state is FavoritesLoadedState) {
                getIt<NavigationService>().navigateReplace(
                  const MoviesScreen(),
                );
              } else if (state is MoviesErroState) {
                getIt<NavigationService>().showSnackbar(state.message);
              }
            },
            bloc: context.read<MoviesBloc>()
              ..add(
                MoviesFetchEvent(),
              ),
          ),
          BlocListener<FavoritesBloc, FavoritesState>(
            listener: (context, state) {
              if (state is FavoritesErrorState) {
                getIt<NavigationService>().showSnackbar(state.message);
              }
            },
            bloc: context.read<FavoritesBloc>()
              ..add(
                FavoritesLoadEvent(),
              ),
          ),
        ],
        child: BlocBuilder<MoviesBloc, MoviesState>(
          bloc: context.read<MoviesBloc>()..add(MoviesFetchEvent()),
          builder: (context, state) {
            if (state is MoviesLoadingState) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Loading..."),
                    SizedBox(height: 20),
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              );
            } else if (state is MoviesErroState) {
              return MyErrorWidget(
                  errorText: state.message, retryFunction: () => context.read<MoviesBloc>()..add(MoviesFetchEvent()));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
