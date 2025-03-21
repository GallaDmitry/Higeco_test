import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:higeco_test/core/bloc/auth/auth_bloc_cubit.dart';

import '../core/repositories/auth_repository.dart';
import '../utils/shared_preferences.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(authenticate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
  void authenticate() async {
    try {
      AuthBlocCubit().authenticate();
    } catch (e) {
      print('Error: $e');
    }
  }
}
