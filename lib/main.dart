import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:higeco_test/utils/router.dart';
import 'package:higeco_test/utils/shared_preferences.dart';
import 'package:higeco_test/views/home_view.dart';
import 'package:higeco_test/views/loading_view.dart';

import 'core/bloc/auth/auth_bloc_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HigecoSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocCubit>(create: (context) => AuthBlocCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Higeco Test',
        routerConfig: router,
        /*home: BlocBuilder<AuthBlocCubit, AuthBlocState>(
          builder: (context, state) {
            return state.isAuth ? HomeView() : LoadingView();
          },
        ),*/
      ),
    );
  }
}