import 'package:vinno_foods/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity> get user;
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);
  Future<UserEntity> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}
