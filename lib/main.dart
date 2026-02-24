import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_pass/core/di/setup_globle_get_it.dart';
import 'package:get_pass/features/admin_dashboard/dependency/admin_di.dart';
import 'package:get_pass/features/auth/di/auth_di.dart';
import 'package:get_pass/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthBloc _authBloc;





  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: globalGetIt<AuthBloc>(),
      child: MaterialApp.router(
        title: 'GetPassSystem',
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Future<void> setupDi() async {
  await setUpGetIt();
  await authGetItFnc();
  await adminGetItFnc();
}
