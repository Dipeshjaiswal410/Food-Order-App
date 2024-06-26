import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? const CircleAvatar()
              : Text(
                  title,
                  style: const TextStyle(color: Colors.black),
                ),
        ),
      ),
    );
  }
}
