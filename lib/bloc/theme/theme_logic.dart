import 'package:bloc/bloc.dart';
import '../../assets/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:math/bloc/theme/theme_state.dart';

class ThemeLogic extends Cubit<ThemeState> {
  ThemeLogic() : super(InitTheme());
  ThemeData theme =
      isAppThemeDark ?? false ? ThemeData.dark() : ThemeData.light();
  bool isDarkIcon = isAppThemeDark ?? false ? false : true;

  void changeTheme() {
    if (theme == ThemeData.light()) {
      updatedIcon(isDark: false);
      theme = ThemeData.dark();
    } else {
      updatedIcon(isDark: true);
      theme = ThemeData.light();
    }
    emit(ChangeTheme());
  }

  updatedIcon({required bool isDark}) {
    isDarkIcon = isDark;
    setAppTheme(isDark: !isDark);
    emit(ChangeThemeIcon());
  }
}
