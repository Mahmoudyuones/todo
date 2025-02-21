import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';

class DefaultElevatedBoutton extends StatelessWidget {
  const DefaultElevatedBoutton(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Appthem.primary,
          fixedSize: Size(MediaQuery.of(context).size.width, 50)),
      child: Text(
        text,
        style:
            TextTheme.of(context).titleMedium!.copyWith(color: Appthem.white),
      ),
    );
  }
}
