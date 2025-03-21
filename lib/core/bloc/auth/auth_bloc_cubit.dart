import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/shared_preferences.dart';
import '../../repositories/auth_repository.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocState.initial()) {
     checkToken();
  }

  void authenticate() async {
    try {
      var body = await AuthRepository().authenticate();
      HigecoSharedPreferences.setAuthToken(body['token']);
      emit(AuthBlocState.authenticated(body['token']));
    } catch (e) {
      emit(AuthBlocState.unauthenticated());
    }
  }
  void checkToken() async {
    String? savedToken = HigecoSharedPreferences.getAuthToken();
    if (savedToken != null) {
      emit(AuthBlocState.authenticated(savedToken));
    } else {
      authenticate();
    }
  }
}