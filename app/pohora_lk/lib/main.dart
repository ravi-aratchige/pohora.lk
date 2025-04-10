import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pohora_lk/blocs/auth/auth_bloc.dart';
import 'package:pohora_lk/data/repositories/auth_repository.dart';
import 'package:pohora_lk/data/repositories/chat_repository.dart';
import 'package:pohora_lk/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authRepository = AuthRepository();
  final chatRepository = ChatRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: chatRepository),
      ],
      child: BlocProvider(
        create:
            (context) => AuthBloc(
              authRepository: authRepository,
              chatRepository: chatRepository,
            ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pohora.lk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 23, 129, 80),
        ),
      ),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.initial,
      debugShowCheckedModeBanner: false,
    );
  }
}
