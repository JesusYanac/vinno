import 'package:equatable/equatable.dart';
import 'package:vinno_foods/features/auth/domain/entities/user_entity.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user = UserEntity.empty,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => errorMessage != null;

  @override
  List<Object?> get props => [status, user, errorMessage];
}
