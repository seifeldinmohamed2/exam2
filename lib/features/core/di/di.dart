import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../api/dataSource/auth_remote_data_source.dart';
import '../../data/repos/auth_repository_impl.dart';
import '../../domain/repositories/auth.dart';
import '../../domain/useCase/forget_password_use_case.dart';
import '../../domain/useCase/reset_password_use_case.dart';
import '../../domain/useCase/sign_in_use_case.dart';
import '../../domain/useCase/sign_up_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

}
