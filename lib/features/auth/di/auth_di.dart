import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/core/storage/token_storage.dart';
import 'package:get_pass/features/auth/data/datasource/auth_datasource.dart';
import 'package:get_pass/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:get_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:get_pass/features/auth/domain/usecase/login_use_case.dart';
import 'package:get_pass/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../core/di/setup_globle_get_it.dart';

Future<void> authGetItFnc() async {
  if (!globalGetIt.isRegistered<AuthRemoteDataSource>()) {
    globalGetIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(globalGetIt<NetworkRepository>(),globalGetIt<TokenStorage>()),
    );
  }

  if (!globalGetIt.isRegistered<AuthRepository>()) {
    globalGetIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(globalGetIt<AuthRemoteDataSource>()),
    );
  }

  if (!globalGetIt.isRegistered<LoginUseCase>()) {
    globalGetIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(globalGetIt<AuthRepository>()),
    );
  }

  if (!globalGetIt.isRegistered<AuthBloc>()) {
    globalGetIt.registerFactory<AuthBloc>(
      () => AuthBloc(loginUseCase: globalGetIt<LoginUseCase>()),
    );
  }
}
