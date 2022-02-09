import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/auth/auth.dart';
import 'package:wordle/blocs/register/register.dart';
import 'package:wordle/screens/home.dart';
import 'package:wordle/utils/constants.dart';
import 'package:wordle/widgets/logo.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (BuildContext context) => RegisterBloc(),
      child: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    context.read<AuthBloc>().add(SignUp(
          _emailController.text,
          _passwordController.text,
        ));
    context.read<RegisterBloc>().add(RegisterAttempted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (_, state) {
          if (state is AuthAuthenticated) {
            context.read<RegisterBloc>().add(RegisterSuccessful());
          }
          if (state is AuthError) {
            context
                .read<RegisterBloc>()
                .add(RegisterFailed(error: state.error));
          }
        }),
        BlocListener<RegisterBloc, RegisterState>(listener: (_, state) {
          if (state is RegisterLoading) {
            setState(() {
              _isLoading = true;
            });
          }
          if (state is RegisterComplete) {
            context.showSnackBar(message: 'Login successful!');
            _emailController.clear();
            _passwordController.clear();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
          }
          if (state is RegisterError) {
            setState(() {
              _isLoading = false;
            });
            context.showErrorSnackBar(message: state.error);
          }
        }),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Logo(
                    maxWidth: null,
                    maxHeight: 40,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  obscureText: !_isPasswordVisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            child: const Text('Register'),
                            style: const ButtonStyle(),
                            onPressed: _isLoading ? null : _register,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
