

import 'package:get_it/get_it.dart';
import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/features/auth/data/datasource/auth_datasource.dart';
import 'package:get_pass/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:get_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:get_pass/features/auth/domain/usecase/login_use_case.dart';
import 'package:get_pass/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../core/di/setup_globle_get_it.dart';

final GetIt authGetIt = GetIt.instance;

Future<void> authGetItFnc()async{
  globalGetIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(globalGetIt<NetworkRepository>()),
  );

  globalGetIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(globalGetIt<AuthRemoteDataSource>()),
  );

  globalGetIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(globalGetIt<AuthRepository>()),
  );

  globalGetIt.registerFactory<AuthBloc>(
        () => AuthBloc(loginUseCase: globalGetIt<LoginUseCase>()),
  );
}