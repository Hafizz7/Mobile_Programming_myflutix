import 'package:flutter/material.dart';

class PromotionContainer extends StatelessWidget {
  const PromotionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 300,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
        ),
        // You can add any child widgets or content here if needed
      ),
    );
  }
}
