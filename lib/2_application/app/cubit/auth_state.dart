part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  final bool isLoggedIn;
  final String? uId;

  const AuthInitial({this.isLoggedIn = false, this.uId});
}
