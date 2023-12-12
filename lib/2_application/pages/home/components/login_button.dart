import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/app/cubit/auth_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      String title = "Login";
      Function onpressed = () => context.pushNamed("login");

      if (state is AuthInitial && state.isLoggedIn) {
        title = "Profile";
        onpressed = () => context.pushNamed("profile");
      }

      return TextButton(onPressed: () => onpressed(), child: Text(title));
    });
  }
}
