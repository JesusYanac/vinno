import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_event.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_state.dart';
import 'package:vinno_foods/features/auth/presentation/pages/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          // Navegar a la pantalla de inicio de sesión
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bienvenido'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 100,
                  color: Colors.green,
                ),
                const SizedBox(height: 24),
                Text(
                  '¡Hola, ${user.name}!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Bienvenido a Vinno Foods',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  'Correo: ${user.email}',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'ID de usuario: ${user.id}',
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la navegación a la pantalla principal de la aplicación
                    // Por ahora, solo mostramos un mensaje
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('¡Bienvenido a la aplicación!'),
                      ),
                    );
                  },
                  child: const Text('Comenzar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
