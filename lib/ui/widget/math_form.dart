import 'package:flutter/material.dart';
import 'package:math_keyboard/math_keyboard.dart';

Widget myMathForm({
  required String hint,
  required MathFieldEditingController controller,
}) =>
    MathField(
      controller: controller,
      keyboardType: MathKeyboardType.expression,
      variables: const ["x", "y", "z"],
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.white70,
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        enabledBorder: customBorder(),
        disabledBorder: customBorder(),
        focusedBorder: customBorder(),
        border: customBorder(),
      ),
    );

OutlineInputBorder customBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(
      width: 3,
      strokeAlign: 1.5,
      color: Colors.black12,
    ),
  );
}
