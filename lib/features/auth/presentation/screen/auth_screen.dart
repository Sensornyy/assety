import 'package:assety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:assety/features/user/presentation/screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      resizeToAvoidBottomInset: false,
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
                padding: const EdgeInsets.only(
                  top: 100.0,
                  left: 16,
                  right: 16,
                  bottom: 24,
                ),
                child: Column(
                  spacing: 24,
                  children: [
                    Text(
                      'Вітаю! Уведіть свої дані для входу',
                      style: textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 64),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Пароль'),
                    ),
                    Spacer(),
                    Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                        child: state is AuthLoading ? CircularProgressIndicator() : Text('Увійти'),
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
