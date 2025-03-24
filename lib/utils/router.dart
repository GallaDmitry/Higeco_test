import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:higeco_test/core/bloc/auth/auth_bloc_cubit.dart';
import 'package:higeco_test/views/devices_view.dart';
import 'package:higeco_test/views/loading_view.dart';
import 'package:higeco_test/views/logs_view.dart';
import 'package:higeco_test/views/statistics/statistics_view.dart';

import '../core/models/log_data_model.dart';
import '../views/home_view.dart';
import '../views/statistics/chart_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          context.watch<AuthBlocCubit>().state.isAuth ? HomeView() : LoadingView(),
    ),
    GoRoute(
      path: '/plant/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DevicesView(plantId: id);
      },
    ),
    GoRoute(
      path: '/device/:plantId/:deviceId',
      builder: (context, state) {
        final plantId = int.parse(state.pathParameters['plantId']!);
        final String deviceId = state.pathParameters['deviceId']!;
        return LogsView(plantId: plantId, deviceId: deviceId);
      },
    ),
    GoRoute(
        path: '/log/:plantId/:deviceId/:logId',
        builder: (context, state) {
          final plantId = int.parse(state.pathParameters['plantId']!);
          final String deviceId = state.pathParameters['deviceId']!;
          final String logId = state.pathParameters['logId']!;
          return StatisticsView(
            plantId: plantId,
            deviceId: deviceId,
            logId: logId,
          );
        }),
    GoRoute(
        path: '/chart',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final logData = extra != null ? extra['logData'] as LogDataModel : null;
          final type = extra != null ? extra['type'] as String : null;
          return ChartView(logData: logData, type: type);
        }),
  ],
);
