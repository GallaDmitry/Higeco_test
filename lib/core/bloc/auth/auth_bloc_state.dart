part of 'auth_bloc_cubit.dart';

class AuthBlocState {
  final bool isAuth;
  final String? token;

  AuthBlocState({
    required this.isAuth,
    this.token,
  });

  factory AuthBlocState.initial() {
    return AuthBlocState(
      isAuth: false,
    );
  }

  factory AuthBlocState.authenticated(String token) {
    return AuthBlocState(
      isAuth: true,
      token: token,
    );
  }

  factory AuthBlocState.unauthenticated() {
    return AuthBlocState(
      isAuth: false,
    );
  }
}