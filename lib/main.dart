import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinno_foods/core/service_locator.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_bloc.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() {
  main2();
}

Future<void> main1() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializar Firebase con las opciones por defecto
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Inicializar el service locator
    await init();

    runApp(
      BlocProvider<AuthBloc>(
        create: (context) => sl<AuthBloc>(),
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    print('Error al inicializar la aplicación: $e');
    print('Stack trace: $stackTrace');

    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error al inicializar la aplicación: ${e.toString()}'),
        ),
      ),
    ));
  }
}


Future<void> main2() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializar Firebase con las opciones por defecto
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Inicializar el service locator
    await init();

    runApp(
      BlocProvider<AuthBloc>(
        create: (context) => sl<AuthBloc>(),
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    print('Error al inicializar la aplicación: $e');
    print('Stack trace: $stackTrace');

    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error al inicializar la aplicación: ${e.toString()}'),
        ),
      ),
    ));
  }
}