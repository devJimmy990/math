import 'chat_state.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import '../../assets/link_api.dart';
import 'package:math/model/message.dart';
import 'package:math/model/database.dart';
import 'package:math/assets/connection.dart';
import 'package:math_keyboard/math_keyboard.dart';

class ChatLogic extends Cubit<ChatState> {
  ChatLogic() : super(InitChatState());
  MathFieldEditingController controller = MathFieldEditingController();
  List<Message> chats = [];
  bool isWaiting = false;
  MyDatabase myDB = MyDatabase();

  startDatabase() async {
    await myDB.initialDatabase();
    await myDB.selectMessages().then((value) => _setFitchMessages(value));
  }

  sendExpression() async {
    final String expression = 
        TeXParser(controller.currentEditingValue()).parse().toString();
    handleExpression(expression);
    controller.clear();
    insertMessage(
        sender: 1,
        content: expression.toString().substring(1, expression.length - 1));
    toggleWaitingState();
    var response = await Connection.getInstance().postRequest(
      url: kPromptAPI,
      data: expression,
    );
    toggleWaitingState();
    print("Response is: ${response["choices"][0]["message"]["content"]}");
    insertMessage(
        sender: 0,
        content: handleContent(response["choices"][0]["message"]["content"]));
  }

  String handleExpression(String expression) {
    String res = "";
    List list = expression.split(".");
    print("Expression is: $expression");
    for (int i = 0; i < list.length; i++) {
      if (list[i][0] == '0') {
        list[i] = list[i].toString().substring(1);
      }
      res += list[i];
    }
    return res;
  }

  String handleContent(String content) {
    String res = "";

    return content;
  }

  void toggleWaitingState() {
    isWaiting = !isWaiting;
    emit(ChangeWaitingState());
  }

  _setFitchMessages(List value) {
    chats.clear();
    for (var msg in value) {
      chats.add(Message.fromJSON(msg));
    }
  }

  insertMessage({required int sender, required String content}) async {
    await myDB.insertMessage(Message(
      sender: sender,
      content: content,
      image: "",
      time: DateFormat('h:mm a').format(DateTime.now()),
    ));
    await myDB.selectMessages().then((value) => _setFitchMessages(value));
    emit(GetMessages());
  }

  deleteChat() async {
    await myDB.deleteMessages().then(
        (value) => insertMessage(sender: 0, content: "Welcome in Math-Bot"));
  }
}
