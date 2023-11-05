class Message {
  late String content, time, image;
  late int sender;
  Message(
      {required this.sender, this.content = "", this.time = "", this.image = ""});

  Message.fromJSON(Map<String, dynamic> map) {
    sender = map["sender"];
    content = map["content"];
    image = map["image"];
    time = map["time"];
  }
}
