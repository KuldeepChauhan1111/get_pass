import 'package:get_it/get_it.dart';
import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/core/network/network_repository_impl.dart';
import 'package:get_pass/core/storage/token_storage.dart';
import 'package:get_pass/core/utils/network_info.dart';
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

  globalGetIt.registerLazySingleton<TokenStorage>(
        () => TokenStorage(),
  );

  globalGetIt.registerLazySingleton<http.Client>(http.Client.new);

  globalGetIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(globalGetIt<InternetConnection>()),
  );

  globalGetIt.registerLazySingleton<NetworkRepository>(
    () => NetworkRepositoryImpl(
      client: globalGetIt<http.Client>(),
      networkInfo: globalGetIt<NetworkInfo>(),
      tokenStorage: globalGetIt<TokenStorage>()
    ),
  );

}
