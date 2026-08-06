import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
final GetIt getIt = GetIt.instance;
Future<void> setupServiceLocator() async {
  // Firebase Auth
  getIt.registerLazySingleton<FirebaseAuth>(
        () => FirebaseAuth.instance,
  );
  // Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  // Repository
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource:
      getIt<AuthRemoteDataSource>(),
    ),
  );
  // Cubit
  getIt.registerFactory<AuthCubit>(
        () => AuthCubit(
      repository:
      getIt<AuthRepository>(),
    ),
  );
}