import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:math/bloc/chat/chat_logic.dart';
import 'package:math/bloc/chat/chat_state.dart';
import 'package:math/ui/screens/my_app_bar.dart';
import 'package:math/ui/widget/offline.dart';
import 'package:math_keyboard/math_keyboard.dart';

// Imported your custom widgets
import '../../assets/strings.dart';
import '../widget/chat_main_icons.dart';
import '../widget/math_form.dart';
import '../widget/message_widget.dart';

class ChatScreen extends StatelessWidget {
  // Fixed the key argument
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatLogic, ChatState>(
      builder: (context, state) {
        ChatLogic chat = BlocProvider.of(context);
        return MathKeyboardViewInsets(
          child: SafeArea(
            child: Builder(
              builder: (BuildContext context) {
                return OfflineBuilder(
                  connectivityBuilder: (BuildContext context,
                      ConnectivityResult connectivity, Widget child) {
                    final bool connected =
                        connectivity != ConnectivityResult.none;
                    return Scaffold(
                        appBar: const MyAppBar(),
                        body: connected
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      child: ListView.builder(
                                        itemCount: chat.chats.length,
                                        itemBuilder: (context, index)
                                        => chat.chats[index].sender == 0
                                            ? myBotMessage(chat.chats[index])
                                            : myUserMessage(chat.chats[index]),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: chat.isWaiting,
                                    child: const Text(kChatWaiting),
                                  ),
                                  SizedBox(
                                    height: 65,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Material(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: myMathForm(
                                                hint: kChatHintMsg,
                                                controller: chat.controller,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          myChatIcons(
                                            icon: Icons.send,
                                            btnBG: Colors.green,
                                            onTap: () async =>
                                                await chat.sendExpression(),
                                          ),
                                          const SizedBox(width: 5),
                                          myChatIcons(
                                            icon: Icons.delete,
                                            btnBG: Colors.red,
                                            onTap: () async =>
                                                await chat.deleteChat(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              )
                            : myOfflineWidget());
                  },
                  child: const SizedBox(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
