import '../widget/my_button.dart';
import '../../assets/strings.dart';
import 'package:flutter/material.dart';
import 'package:math/ui/screens/my_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                myButton(
                    onTap: () => Navigator.of(context).pushNamed(kScreenChat),
                    label: kHomeChat),
                myButton(
                  onTap: () => Navigator.of(context).pushNamed(kScreenCalc),
                  label: (kHomeCalculator),
                ),
                myButton(
                    onTap: () => Navigator.of(context).pushNamed(kScreenGraph),
                    label: kHomeGraph),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
