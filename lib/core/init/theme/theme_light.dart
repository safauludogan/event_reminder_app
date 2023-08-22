import 'package:event_reminder_app/core/constants/colors.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomThemeLight {
  CustomThemeLight(this.context);
  BuildContext context;

  ThemeData get theme => ThemeData.light().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: ColorConstants.backgroundColor,
        elevatedButtonTheme: elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonThemeData(),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        dividerColor: Colors.grey,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme(),
      );

  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: ColorConstants.backgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorConstants.primaryColor),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      );

  ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      backgroundColor: Colors.blue,
    ),
  );

  OutlinedButtonThemeData _outlinedButtonThemeData() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(16),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor:MaterialStateProperty.all<Color>(ColorConstants.primaryColor),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      focusedBorder: _inputDecorationCustomOutlined,
      enabledBorder: _inputDecorationCustomOutlined,
      focusedErrorBorder: _inputDecorationCustomErrorOutlined,
      errorBorder: UnderlineInputBorder(
        borderRadius: _inputRadius,
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      border: _inputDecorationCustomErrorOutlined,
      labelStyle: context.textTheme.titleSmall!.copyWith(color: Colors.grey),
      alignLabelWithHint: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.only(left: 12),
      errorStyle: context.textTheme.labelMedium
          ?.copyWith(color: Colors.red, fontWeight: FontWeight.w500),
      hintStyle: context.textTheme.labelSmall,
    );
  }

  InputBorder get _inputDecorationCustomOutlined => UnderlineInputBorder(
        borderRadius: _inputRadius,
        borderSide: const BorderSide(
          width: 1.5,
        ),
      );
  InputBorder get _inputDecorationCustomErrorOutlined => UnderlineInputBorder(
        borderRadius: _inputRadius,
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      );
  BorderRadius get _inputRadius => const BorderRadius.all(Radius.circular(8));
}
