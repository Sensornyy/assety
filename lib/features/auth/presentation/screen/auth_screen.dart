import 'dart:io';

import 'package:assety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:assety/features/user/presentation/screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              if (state.shouldSignOut) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserScreen(),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      'Welcome!',
                      style: textTheme.displaySmall,
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    Spacer(),
                    Text(
                      'Continue with:',
                      style: textTheme.headlineSmall,
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            bloc.add(
                              SignInWithApple(),
                            );
                          },
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/google.svg',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                        if (Platform.isIOS)
                          GestureDetector(
                            onTap: () {
                              bloc.add(
                                SignInWithApple(),
                              );
                            },
                            child: Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/apple.svg',
                                  colorFilter: ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.add(
                            SignUpWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                        style: ButtonStyle(
                          textStyle: WidgetStateProperty.all(textTheme.headlineSmall),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child:
                            state is AuthLoading ? CircularProgressIndicator() : Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
