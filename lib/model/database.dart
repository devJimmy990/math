import 'message.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  late Database _myDB;

  initialDatabase() async {
    final String path = "${await getDatabasesPath()}/math.db";
    await openDatabase(path, version: 1, onCreate: _onCreate).then((value) {
      _myDB = value;
    });
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE `message` (
    sender INTEGER NOT NULL,
    content TEXT NOT NULL,
    image TEXT ,
    time TEXT NOT NULL)''');
  }

  Future deleteMessages() async => await _myDB.rawDelete("DELETE FROM message");

  insertMessage(Message msg) async =>
      await _myDB.transaction((txn) => txn.rawInsert('''
              INSERT INTO message(sender, content, image, time) 
              VALUES('${msg.sender}', '${msg.content}', '${msg.image}', '${msg.time}')
          '''));

  Future selectMessages() async => await _myDB.rawQuery("SELECT * FROM message");
}
