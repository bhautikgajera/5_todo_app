import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial(isLoggedIn: false));

  void authStateChanged({User? user}) {
    print("User =>>>>>>>>>>>>    $user");
    if (user == null) return;
    emit(AuthInitial(isLoggedIn: true, uId: user.uid));
  }
}
