import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_bloc.dart';

import 'features/auth/presentation/blocs/auth_state.dart';
import 'features/auth/presentation/pages/login.dart';
import 'features/auth/presentation/pages/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vinno Foods',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 64),
          displayMedium: TextStyle(fontSize: 52),
          displaySmall: TextStyle(fontSize: 44),
          headlineLarge: TextStyle(fontSize: 40),
          headlineMedium: TextStyle(fontSize: 36),
          headlineSmall: TextStyle(fontSize: 32),
          titleLarge: TextStyle(fontSize: 28),
          titleMedium: TextStyle(fontSize: 24),
          titleSmall: TextStyle(fontSize: 20),
          bodyLarge: TextStyle(fontSize: 24),
          bodyMedium: TextStyle(fontSize: 20),
          bodySmall: TextStyle(fontSize: 16),
          labelLarge: TextStyle(fontSize: 24),
          labelMedium: TextStyle(fontSize: 20),
          labelSmall: TextStyle(fontSize: 16),
        ),
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(130, 15, 40, 1),
          onPrimary: Color.fromRGBO(253, 253, 253, 1),
          primaryContainer: Color.fromRGBO(248, 235, 238, 1),
          onPrimaryContainer: Color.fromRGBO(130, 15, 40, 1),
          inversePrimary: Colors.transparent,
          secondary: Color.fromRGBO(9, 71, 94, 1),
          onSecondary: Color.fromRGBO(253, 253, 253, 1),
          secondaryContainer: Color.fromRGBO(224, 240, 246, 1),
          onSecondaryContainer: Color.fromRGBO(9, 71, 94, 1),
          tertiary: Colors.transparent,
          onTertiary: Colors.transparent,
          tertiaryContainer: Colors.transparent,
          onTertiaryContainer: Colors.transparent,
          background: Color.fromRGBO(217, 220, 221, 1),
          onBackground: Color.fromRGBO(27, 24, 24, 1),
          surface: Color.fromRGBO(253, 253, 253, 1),
          onSurface: Color.fromRGBO(38, 42, 44, 1),
          surfaceVariant: Color.fromRGBO(242, 242, 242, 1),
          onSurfaceVariant: Color.fromRGBO(82, 82, 82, 1),
          surfaceTint: Colors.transparent,
          error: Color.fromRGBO(207, 35, 73, 1),
          onError: Colors.transparent,
          errorContainer: Colors.transparent,
          onErrorContainer: Colors.transparent,
          outline: Color.fromRGBO(121, 120, 120, 1),
          outlineVariant: Color.fromRGBO(202, 205, 206, 1),
          shadow: Color.fromRGBO(0, 0, 0, 1),
          //link: Color.fromRGBO(22, 142, 233, 1),
          //success: Color.fromRGBO(103, 212, 153, 1),
          //warning: Color.fromRGBO(238, 202, 77, 1),
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            return const WelcomeScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}