import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinno_foods/features/auth/domain/entities/user_entity.dart';
import 'package:vinno_foods/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Stream<UserEntity> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserEntity.empty : firebaseUser.toEntity;
      return user;
    });
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.toEntity;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      
      return userCredential.user!.toEntity;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return Exception('El correo electrónico no es válido');
      case 'user-disabled':
        return Exception('Esta cuenta ha sido deshabilitada');
      case 'user-not-found':
        return Exception('No se encontró ninguna cuenta con este correo');
      case 'wrong-password':
        return Exception('Contraseña incorrecta');
      case 'email-already-in-use':
        return Exception('Ya existe una cuenta con este correo electrónico');
      case 'weak-password':
        return Exception('La contraseña es demasiado débil');
      default:
        return Exception('Error de autenticación: ${e.message}');
    }
  }
}

extension on User {
  UserEntity get toEntity => UserEntity(
        id: uid,
        email: email,
        name: displayName,
        photoUrl: photoURL,
      );
}
