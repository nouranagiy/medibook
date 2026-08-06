import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit({
    required this.repository,
  }) : super(AuthInitial());
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await repository.login(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(
        AuthFailure(
          e.toString(),
        ),
      );
    }
  }
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await repository.register(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated());
    } catch(e){
      emit(
        AuthFailure(
          e.toString(),
        ),
      );
    }
  }
  Future<void> logout() async {
    await repository.logout();
  }
}