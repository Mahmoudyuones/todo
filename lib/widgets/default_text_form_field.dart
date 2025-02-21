import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator});
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Appthem.black, fontWeight: FontWeight.w500),
      ),
      validator: validator,
    );
  }
}
