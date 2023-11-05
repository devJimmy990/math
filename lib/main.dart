import 'bloc/chat/chat_logic.dart';
import 'ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:math/assets/strings.dart';
import 'ui/screens/calculator_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/bloc/theme/theme_state.dart';
import 'package:math/bloc/theme/theme_logic.dart';
import 'package:math/ui/screens/chat_screen.dart';
import 'package:math/ui/screens/graph_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math/bloc/calculator/calculator_logic.dart';

late SharedPreferences themePrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  themePrefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeLogic()),
        BlocProvider(create: (_) => CalculatorLogic()),
        BlocProvider(create: (_) => ChatLogic()..startDatabase())
      ],
      child: BlocBuilder<ThemeLogic, ThemeState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.read<ThemeLogic>().theme,
          routes: {
            kScreenHome: (context) => const HomeScreen(),
            kScreenChat: (context) => const ChatScreen(),
            kScreenGraph: (context) => const GraphScreen(),
            kScreenCalc: (context) => const CalculatorScreen(),
          },
          home: const HomeScreen(),
        );
      }),
    );
  }
}
