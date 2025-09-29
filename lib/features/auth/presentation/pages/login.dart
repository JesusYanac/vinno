import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_state.dart';
import 'package:vinno_foods/features/auth/presentation/templates/template_login.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          // Navegar a la pantalla principal cuando el usuario esté autenticado
          // Navigator.pushReplacementNamed(context, '/home');
          // Por ahora, solo mostramos un mensaje
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Inicio de sesión exitoso!')),
          );
        } else if (state.status == AuthStatus.failure && state.errorMessage != null) {
          // Mostrar mensaje de error si hay alguno
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: const Scaffold(
        body: TemplateLogin(),
      ),
    );
  }
}
