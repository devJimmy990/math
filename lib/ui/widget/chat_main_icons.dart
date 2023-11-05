import 'package:flutter/material.dart';

Widget myChatIcons({
  required void Function() onTap,
  required IconData icon,
  required Color btnBG,
  double size =28,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: btnBG,
        child: Icon(icon, color: Colors.white, size: size),
      ),
    ),
  );
}
