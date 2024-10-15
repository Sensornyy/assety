import 'package:assety/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:assety/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final UserBloc _userBloc = UserBloc();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _userBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: _userBloc..add(GetUser()),
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is UserSuccess) {
                print('fdfdf');
                final user = state.user;

                _emailController.text = user.email ?? '';
                _nameController.text =
                    _nameController.text.isNotEmpty ? _nameController.text : user.displayName ?? '';
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          'User ID: ',
                          style: textTheme.displaySmall,
                        ),
                        Text(user.uid, style: textTheme.bodyLarge),
                        SizedBox(height: 30),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          readOnly: true,
                        ),
                        TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _userBloc.add(
                                UpdateUser(
                                  displayName: _nameController.text,
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
                                state is UserLoading ? CircularProgressIndicator() : Text('Save'),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              _userBloc.add(DeleteUser());
                              authBloc.add(SignOut());
                            },
                            style: ButtonStyle(
                              textStyle: WidgetStateProperty.all(textTheme.headlineSmall),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: state is UserLoading
                                ? CircularProgressIndicator()
                                : Text('Delete user'),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              authBloc.add(SignOut());
                            },
                            style: ButtonStyle(
                              textStyle: WidgetStateProperty.all(textTheme.headlineSmall),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: state is UserLoading
                                ? CircularProgressIndicator()
                                : Text('Sign out'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
