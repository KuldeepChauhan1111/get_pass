import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/core/network/network_repository_impl.dart';
import 'package:get_pass/core/utils/network_info.dart';

final GetIt globalGetIt = GetIt.instance;

Future<void> setUpGetIt() async {
  //network info
  globalGetIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(globalGetIt()),
  );

  //http get_it
  globalGetIt.registerLazySingleton<NetworkRepository>(
    () => NetworkRepositoryImpl(client: globalGetIt()),
  );
}
