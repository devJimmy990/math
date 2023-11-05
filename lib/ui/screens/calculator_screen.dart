import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/bloc/calculator/calculator_logic.dart';
import 'package:math/bloc/calculator/calculator_state.dart';
import 'package:math/ui/screens/my_app_bar.dart';


@immutable
class AppColor {
  static const Color grey = Color.fromARGB(255, 134, 134, 134);
  static const Color red = Color.fromARGB(255, 255, 0, 0);
  const AppColor._();
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CalculatorResult(),
            Divider(
                height: size.height * 0.01,
                thickness: 1,
                color: AppColor.grey.withOpacity(0.2)),
            const CalculatorButtons(),
          ],
        ),
      ),
    );
  }
}

class CalculatorResult extends StatelessWidget {
  const CalculatorResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorLogic, CalculatorState>(
        builder: (context, state) {
      final size = MediaQuery.of(context).size;
      CalculatorLogic logic = BlocProvider.of(context);
      return SizedBox(
        height: size.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: const Alignment(0.9, 1),
              child: Text(logic.getEquation,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: size.height * 0.05),
            Align(
              alignment: const Alignment(0.9, 1),
              child: Text(logic.getResult,
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    });
  }
}

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      child: Table(
        children: const [
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, '2nd'),
              CalculatorButton(AppColor.grey, 1, 'deg'),
              CalculatorButton(AppColor.grey, 1, 'sin'),
              CalculatorButton(AppColor.grey, 1, 'cos'),
              CalculatorButton(AppColor.grey, 1, 'tan'),
            ],
          ),
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, 'x^y'),
              CalculatorButton(AppColor.grey, 1, 'log'),
              CalculatorButton(AppColor.grey, 1, 'ln'),
              CalculatorButton(AppColor.grey, 1, '('),
              CalculatorButton(AppColor.grey, 1, ')'),
            ],
          ),
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, '√x'),
              CalculatorButton(AppColor.red, 1, 'AC'),
              CalculatorButton(AppColor.red, 1, '⌫'),
              CalculatorButton(AppColor.red, 1, '%'),
              CalculatorButton(AppColor.red, 1, '÷'),
            ],
          ),
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, 'X!'),
              CalculatorButton(AppColor.grey, 1, '7'),
              CalculatorButton(AppColor.grey, 1, '8'),
              CalculatorButton(AppColor.grey, 1, '9'),
              CalculatorButton(AppColor.red, 1, '×'),
            ],
          ),
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, '1⁄x'),
              CalculatorButton(AppColor.grey, 1, '4'),
              CalculatorButton(AppColor.grey, 1, '5'),
              CalculatorButton(AppColor.grey, 1, '6'),
              CalculatorButton(AppColor.red, 1, '-'),
            ],
          ),
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, 'π'),
              CalculatorButton(AppColor.grey, 1, '1'),
              CalculatorButton(AppColor.grey, 1, '2'),
              CalculatorButton(AppColor.grey, 1, '3'),
              CalculatorButton(AppColor.red, 1, '+'),
            ],
          ),
          TableRow(
            children: [
              CalculatorButton(AppColor.grey, 1, '?'),
              CalculatorButton(AppColor.grey, 1, 'e'),
              CalculatorButton(AppColor.grey, 1, '0'),
              CalculatorButton(AppColor.grey, 1, '.'),
              CalculatorButton(AppColor.red, 1, '='),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(this.color, this.height, this.text, {super.key});
  final String text;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6 / 7 * height,
      child: BlocBuilder<CalculatorLogic, CalculatorState>(
        builder: (context, state) {
          CalculatorLogic logic = BlocProvider.of(context);
          return TextButton(
            onPressed: () => logic.getPressedText(text),
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                foregroundColor: Colors.grey),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
