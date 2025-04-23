import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/input_field.dart';
import '../navigation/app_navigator.dart';
import '../routes.dart';
import '../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 40),
                const Text('Welcome Back', 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                const Text('Sign in to continue',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                AppInputField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Text('+91 '),
                  isRequired: true,
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 16),
                AppInputField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: !_isPasswordVisible,
                  isRequired: true,
                  validator: Validators.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible 
                        ? Icons.visibility_off 
                        : Icons.visibility),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => AppNavigator.pushNamed(AppRoutes.resetPassword),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: 'Sign In',
                  onPressed: _login,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => AppNavigator.pushNamed(AppRoutes.register),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Implement login logic
      AppNavigator.pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}