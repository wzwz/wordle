import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/auth/auth.dart';
import 'package:wordle/blocs/login/login.dart';
import 'package:wordle/screens/home.dart';
import 'package:wordle/screens/register.dart';
import 'package:wordle/utils/constants.dart';
import 'package:wordle/widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    context.read<AuthBloc>().add(LogIn(
          _emailController.text,
          _passwordController.text,
        ));
    context.read<LoginBloc>().add(LoginAttempted());
  }

  Future<void> _signInAnonymously() async {
    context.read<AuthBloc>().add(LogInAnonymously());
    context.read<LoginBloc>().add(LoginAttempted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (_, state) {
          if (state is AuthAuthenticated) {
            context.read<LoginBloc>().add(LoginSuccessful());
          }
          if (state is AuthError) {
            context.read<LoginBloc>().add(LoginFailed(error: state.error));
          }
        }),
        BlocListener<LoginBloc, LoginState>(listener: (_, state) {
          if (state is LoginLoading) {
            setState(() {
              _isLoading = true;
            });
          }
          if (state is LoginComplete) {
            context.showSnackBar(message: 'Login successful!');
            _emailController.clear();
            _passwordController.clear();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
          }
          if (state is LoginError) {
            setState(() {
              _isLoading = false;
            });
            context.showErrorSnackBar(message: state.error);
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _loginFormKey,
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
                    height: 40,
                  ),
                  TextField(
                    enabled: !_isLoading,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: ThemeDefault.inputStyle.copyWith(
                      labelText: 'Email address',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: !_isLoading,
                    cursorColor: Colors.white,
                    obscureText: !_isPasswordVisible,
                    controller: _passwordController,
                    decoration: ThemeDefault.inputStyle.copyWith(
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
                              child: const Text('Log In'),
                              style: ElevatedButton.styleFrom(
                                primary: ThemeDefault.colorPrimary,
                              ),
                              onPressed: _isLoading ? null : _signIn,
                            ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: ThemeDefault.colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, RegisterScreen.id),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      text: 'Sign in as guest',
                      style: const TextStyle(
                        color: ThemeDefault.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _signInAnonymously(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
