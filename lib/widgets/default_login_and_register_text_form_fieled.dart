import 'package:flutter/material.dart';

class DefaultLoginAndRegisterTextFormFieled extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  const DefaultLoginAndRegisterTextFormFieled(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.isPassword = false});

  @override
  State<DefaultLoginAndRegisterTextFormFieled> createState() =>
      _DefaultLoginAndRegisterTextFormFieledState();
}

class _DefaultLoginAndRegisterTextFormFieledState
    extends State<DefaultLoginAndRegisterTextFormFieled> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: isObscure
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              )
            : null,
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
