import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/widgets/default_elevated_boutton.dart';
import 'package:todo/widgets/default_login_and_register_text_form_fieled.dart';
import 'package:todo/widgets/firebasefunctions.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 25),
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
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter the Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Email',
                  controller: emailController,
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
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Password can not be less than 8 charactar';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                DefaultElevatedBoutton(text: "Register", onPressed: register),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text(
                    'Allready have an account? Login',
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

  void register() {
    if (formkey.currentState!.validate()) {
      Firebasefunctions.register(
              name: nameController.text,
              email: emailController.text,
              password: passwordController.text)
          .then((user) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((Error) {
        String? message;
        if (Error is FirebaseAuthException) {
          message = Error.message;
        }
        Fluttertoast.showToast(
            msg: message ?? "Something went Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Appthem.red,
            textColor: Appthem.white,
            fontSize: 16.0);
      });
    }
  }
}
