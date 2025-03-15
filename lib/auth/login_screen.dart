import 'package:flutter/material.dart';
import 'package:todo/widgets/default_elevated_boutton.dart';
import 'package:todo/widgets/default_login_and_register_text_form_fieled.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 25,
              ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Email',
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter the Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Password',
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.trim().length < 8)
                      return 'Password can not be less than 8 charactar';
                  },
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                DefaultElevatedBoutton(text: "Login", onPressed: login),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  child: Text(
                    'Dont have an account?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formkey.currentState!.validate()) {
      print('login');
    }
  }
}
