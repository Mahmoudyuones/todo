import 'package:cloud_firestore/cloud_firestore.dart';
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
                    if (value == null || value.trim().length < 8) {
                      return 'Password can not be less than 8 charactar';
                    }
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
      FocusScope.of(context).unfocus();
      Firebasefunctions.login(
              email: emailcontroller.text, password: passwordcontroller.text)
          .then((user) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError(
        (error) {
          String? message;
          if (error is FirebaseAuthException) {
            message = error.message;
          }
          Fluttertoast.showToast(
              msg: message ?? "Something went Wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Appthem.red,
              textColor: Appthem.white,
              fontSize: 16.0);
        },
      );
    }
  }
}
