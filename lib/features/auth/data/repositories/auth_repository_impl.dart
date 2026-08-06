import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(
      email: email,
      password: password,
    );
  }
  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.register(
      email: email,
      password: password,
    );
  }
  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}