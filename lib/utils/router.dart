import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/bloc/auth/auth_bloc_cubit.dart';
import 'package:higeco_test/views/loading_view.dart';

import '../views/plant_view.dart';
import '../views/home_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => context.watch<AuthBlocCubit>().state.isAuth ? HomeView() : LoadingView(),
    ),
    GoRoute(
      path: '/plant/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PlantView(plantId: id);
      },
    ),
  ],
);
