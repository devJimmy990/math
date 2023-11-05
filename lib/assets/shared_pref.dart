import 'package:math/main.dart';

const String kIsAppThemeDark = "isDark";

setAppTheme({required bool isDark}) =>
    themePrefs.setBool(kIsAppThemeDark, isDark);

bool? get isAppThemeDark
=> themePrefs.getBool(kIsAppThemeDark);
