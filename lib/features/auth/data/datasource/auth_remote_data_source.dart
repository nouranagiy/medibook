import 'package:firebase_auth/firebase_auth.dart';
class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSource({
    required this.firebaseAuth,
  });
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}