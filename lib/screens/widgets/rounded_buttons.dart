import 'package:flutter/material.dart';

import '../../consts.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.colour, required this.title, required this.onPress});

  final Color colour;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 60.0,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kWhiteColor,
            )
          ),
        ),
      ),
    );
  }
}