import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:math/assets/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/bloc/theme/theme_logic.dart';
import 'package:math/bloc/theme/theme_state.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Navigator.of(context).pushReplacementNamed(kScreenHome),
        child: const Icon(CupertinoIcons.home, color: Colors.black),
      ),
      elevation: 1,
      actions: [
        BlocBuilder<ThemeLogic, ThemeState>(
          builder: (context, state) {
            final theme = context.read<ThemeLogic>();
            return InkWell(
              onTap: () => theme.changeTheme(),
              child: Icon(
                theme.isDarkIcon ? Icons.nights_stay_rounded : Icons.sunny,
                size: 30,
                color: Colors.black,
                fill: .5,
              ),
            );
          },
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
