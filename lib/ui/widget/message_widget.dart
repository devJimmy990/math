import '../../model/message.dart';
import 'package:flutter/material.dart';

Widget myBotMessage(Message msg) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: SingleChildScrollView(scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Case Bot Sender
          msgAvatar("Bot"),
          const SizedBox(width: 1.5),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                shape: BoxShape.rectangle,
                color: Colors.black54),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  msgTextResult(msg.content),
                  const SizedBox(height: 8),
                  msgTextTime(msg.time),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget myUserMessage(Message msg) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
            color: Colors.black54),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              msgTextResult(msg.content),
              const SizedBox(height: 8),
              msgTextTime(msg.time),
            ],
          ),
        ),
      ),
      const SizedBox(width: 1.5),
      msgAvatar("MG"),
    ],
  );
}

Widget msgTextResult(String msg) {
  return Text(
    msg,
    style: const TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
  );
}

Widget msgTextTime(String time) {
  return Text(
    time,
    style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700),
  );
}

Widget msgAvatar(String label) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: CircleAvatar(
      radius: 28,
      child: Text(label),
    ),
  );
}
