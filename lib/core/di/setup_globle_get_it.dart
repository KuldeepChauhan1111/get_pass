import 'package:get_it/get_it.dart';
import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/core/network/network_repository_impl.dart';
import 'package:get_pass/core/utils/network_info.dart';
import 'package:get_pass/features/auth/data/datasource/auth_datasource.dart';
import 'package:get_pass/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:get_pass/features/auth/domain/repository/auth_repository.dart';
import 'package:get_pass/features/auth/domain/usecase/login_use_case.dart';
import 'package:get_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final GetIt globalGetIt = GetIt.instance;

Future<void> setUpGetIt() async {
  if (globalGetIt.isRegistered<AuthBloc>()) {
    return;
  }

  globalGetIt.registerLazySingleton<InternetConnection>(
    InternetConnection.createInstance,
  );

  globalGetIt.registerLazySingleton<http.Client>(http.Client.new);

  globalGetIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(globalGetIt<InternetConnection>()),
  );

  globalGetIt.registerLazySingleton<NetworkRepository>(
    () => NetworkRepositoryImpl(
      client: globalGetIt<http.Client>(),
      networkInfo: globalGetIt<NetworkInfo>(),
    ),
  );

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
