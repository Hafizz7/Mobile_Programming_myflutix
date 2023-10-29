import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';

class HomeCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  HomeCustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        width: 100,
        height: 25,
        decoration: ShapeDecoration(
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        )),
      ),
    );
  }
}
