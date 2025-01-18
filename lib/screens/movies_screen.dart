import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/main.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_bloc.dart';
import 'package:mvvm_statemanagements/view_models/theme/theme_bloc.dart';

import '../constants/my_app_icons.dart';
import '../service/init_getit.dart';
import '../service/navigation_service.dart';
import '../widgets/movies/movies_widget.dart';
import 'favorites_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(MoviesWidget());
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () async {
              context.read<ThemeBloc>().add(ThemeToggleEvent());
              // getIt<ThemeBloc>().add(ThemeToggleEvent());
            },
            icon: BlocSelector<ThemeBloc, ThemeState, bool>(
              selector: (state) {
                return state is ThemeDarkState;
              },
              builder: (context, state) {
                return Icon(
                  !state ? MyAppIcons.darkMode : MyAppIcons.lightMode,
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        bloc: context.read<MoviesBloc>(),
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is MoviesErroState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MoviesLoadingMoreState || state is MoviesLoadedState) {
            final movies = state is MoviesLoadedState ? state.movies : (state as MoviesLoadingMoreState).movies;
            bool isLoadingMore = state is MoviesLoadingMoreState;
            int itemCount = isLoadingMore ? movies.length + 1 : movies.length;

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification.metrics.pixels == notification.metrics.maxScrollExtent && !isLoadingMore) {
                  context.read<MoviesBloc>().add(MoviesFetchMoreEvent());
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index >= movies.length && isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                  return MoviesWidget();
                },
              ),
            );
          }
          return const Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }
}
