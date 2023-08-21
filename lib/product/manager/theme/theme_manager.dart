import 'package:event_reminder_app/core/init/cache/locale_manager.dart';
import 'package:event_reminder_app/core/init/theme/theme_dark.dart';
import 'package:event_reminder_app/core/init/theme/theme_light.dart';
import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeType _currentThemeType = ThemeType.light;

  ThemeData? getThemeData(BuildContext context) {
    final result = LocaleManager.instance.getStringValue(PreferencesKeys.theme);
    if (result == null) return CustomThemeLight(context).theme;
    _currentThemeType =
        ThemeType.values.firstWhere((element) => element.toString() == result);
    return (_currentThemeType == ThemeType.light)
        ? CustomThemeLight(context).theme
        : CustomThemeDark(context).theme;
  }

  void changeTheme() {
    switch (_currentThemeType) {
      case ThemeType.light:
        _currentThemeType = ThemeType.dark;
      case ThemeType.dark:
        _currentThemeType = ThemeType.light;
    }
    LocaleManager.instance.setStringValue(
      PreferencesKeys.theme,
      value: _currentThemeType.toString(),
    );
    notifyListeners();
  }
}
