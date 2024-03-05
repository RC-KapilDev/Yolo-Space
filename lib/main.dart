import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/homescreen.dart';
import 'providers/user_provider.dart';
import 'package:yolo/screens/signup_screen.dart';
import 'services/auth_services.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Duration duration = const Duration(seconds: 10);
  Timer? timer;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(duration, (timer) {
      // Call fetchData periodically
      authService.getUserData(context);
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? const SignupScreen()
          : const HomeScreen(),
    );
  }
}
