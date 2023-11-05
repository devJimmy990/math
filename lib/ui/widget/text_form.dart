import 'package:flutter/material.dart';

Widget myTextForm({
  String label = "",
  required TextEditingController controller,
  double maxWidth = 35,
  bool isNum = true,
  Color color = Colors.black,
  Color fillColor = Colors.amber,
}) =>
    TextFormField(
      controller: controller,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: 18,
      ),
      keyboardType:isNum? TextInputType.number: TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        fillColor: fillColor,
        filled: true,
        prefixIconConstraints: BoxConstraints(minWidth: 0, maxWidth: maxWidth),
        prefixIcon: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
