import 'package:flutter/material.dart';
import 'package:get_pass/core/di/setup_globle_get_it.dart';

import 'features/auth/presentation/pages/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetPassSystem',
      theme: ThemeData(useMaterial3: true),
      home: LoginScreen(),
    );
  }
}
