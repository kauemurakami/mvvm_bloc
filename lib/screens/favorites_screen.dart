import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';
import 'package:mvvm_statemanagements/widgets/movies/movies_widget.dart';
import 'package:mvvm_statemanagements/widgets/my_error_widget.dart';

import '../constants/my_app_icons.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FavoritesBloc>().add(FavoritesRemoveAllEvent());
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is FavoritesErrorState) {
            return MyErrorWidget(
              errorText: state.message,
              retryFunction: () => context.read<FavoritesBloc>().add(FavoritesLoadEvent()),
            );
          } else if (state is FavoritesLoadedState) {
            if (state.favorites.isEmpty) {
              return const Center(
                child: Text('No added favorites'),
              );
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return MoviesWidget(
                  movieModel: state.favorites[index],
                ); //const Text("data");
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
