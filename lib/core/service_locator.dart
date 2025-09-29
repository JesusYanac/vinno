import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:vinno_foods/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vinno_foods/features/auth/domain/repositories/auth_repository.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuth: sl()),
  );
  
  // Blocs
  sl.registerFactory(
    () => AuthBloc(authRepository: sl()),
  );
}
