import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_pass/core/di/setup_globle_get_it.dart';
import 'package:get_pass/features/auth/di/auth_di.dart';
import 'package:get_pass/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_pass/features/auth/presentation/pages/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetPassSystem',
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider<AuthBloc>(
        create: (_) => globalGetIt<AuthBloc>(),
        child: const LoginScreen(),
      ),
    );
  }
}


Future<void> setupDi()async{
  await setUpGetIt();
  await authGetItFnc();
}
