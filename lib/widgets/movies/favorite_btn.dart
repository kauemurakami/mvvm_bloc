import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_bloc.dart';

import '../../constants/my_app_icons.dart';

//using blocconsumer
class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesErrorState) {
          getIt<NavigationService>().showSnackbar('An error ocurred ${state.message}');
        }
      },
      bloc: context.read<FavoritesBloc>(),
      builder: (context, state) {
        bool isFavorite = (state is FavoritesLoadedState) && state.favorites.any((movie) => movie.id == movieModel.id);
        return IconButton(
          onPressed: () {
            context.read<FavoritesBloc>().add(
                  isFavorite
                      ? FavoritesRemoveEvent(
                          movieModel: movieModel,
                        )
                      : FavoritesAddEvent(
                          movieModel: movieModel,
                        ),
                );
            // if (state) {
            //   context.read<FavoritesBloc>().add(FavoritesRemoveEvent(movieModel: movieModel));
            // } else {
            //   context.read<FavoritesBloc>().add(FavoritesAddEvent(movieModel: movieModel));
            // }

            // TODO: Implement the favorite logic
          },
          icon: Icon(
            isFavorite ? MyAppIcons.favoriteRounded : MyAppIcons.favoriteOutlineRounded,
            color: isFavorite ? Colors.red : null, // isFavorite ? Colors.red : null,
            size: 20,
          ),
        );
      },
    );
  }
}

//using blocbuilder
// class FavoriteBtnWidget extends StatelessWidget {
//   const FavoriteBtnWidget({super.key, required this.movieModel});
//   final MovieModel movieModel;
//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<FavoritesBloc, FavoritesState, bool>(
//       bloc: context.read<FavoritesBloc>(),
//       selector: (state) => (state is FavoritesLoadedState) && state.favorites.any((movie) => movie.id == movieModel.id),
//       builder: (context, state) {
//         return IconButton(
//           onPressed: () {
//             context.read<FavoritesBloc>().add(
//                   state
//                       ? FavoritesRemoveEvent(
//                           movieModel: movieModel,
//                         )
//                       : FavoritesAddEvent(
//                           movieModel: movieModel,
//                         ),
//                 );
//             // if (state) {
//             //   context.read<FavoritesBloc>().add(FavoritesRemoveEvent(movieModel: movieModel));
//             // } else {
//             //   context.read<FavoritesBloc>().add(FavoritesAddEvent(movieModel: movieModel));
//             // }

//             // TODO: Implement the favorite logic
//           },
//           icon: Icon(
//             state ? MyAppIcons.favoriteRounded : MyAppIcons.favoriteOutlineRounded,
//             color: state ? Colors.red : null, // isFavorite ? Colors.red : null,
//             size: 20,
//           ),
//         );
//       },
//     );
//   }
// }
