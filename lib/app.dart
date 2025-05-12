import 'package:assety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:assety/features/auth/presentation/screen/auth_screen.dart';
import 'package:assety/features/investments/crypto/presentation/screens/add_crypto_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        home: AuthScreen(),
      ),
    );
  }
}
