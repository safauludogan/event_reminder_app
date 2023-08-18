import 'package:flutter/material.dart';
import 'package:event_reminder_app/core/constants/colors.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';

abstract class ISocialAdapter {
  Future<String?> make();
  SocialAdapterModel get model;
}

class AppleAdapter implements ISocialAdapter {
  @override
  Future<String?> make() async {
    return toString();
  }

  @override
  SocialAdapterModel get model => SocialAdapterModel.apple();
}

class GoogleAdapter implements ISocialAdapter {
  @override
  Future<String?> make() async {
    return toString();
  }

  @override
  SocialAdapterModel get model => SocialAdapterModel.google();
}

class FacebookAdapter implements ISocialAdapter {
  @override
  Future<String?> make() async {
    return toString();
  }

  @override
  SocialAdapterModel get model => SocialAdapterModel.facebook();
}

class SocialAdapterModel {
  SocialAdapterModel({
    required this.title,
    required this.color,
    required this.icon,
  });

  factory SocialAdapterModel.facebook() => SocialAdapterModel(
        title: StringConstants.facebook,
        color: ColorConstants.facebookBlueColor,
        icon: Icons.facebook,
      );
  factory SocialAdapterModel.google() => SocialAdapterModel(
        title: StringConstants.google,
        color: ColorConstants.googleRedColor,
        icon: Icons.g_mobiledata_rounded,
      );
  factory SocialAdapterModel.apple() => SocialAdapterModel(
        title: StringConstants.apple,
        color: ColorConstants.appleBlackColor,
        icon: Icons.apple,
      );
  final String title;
  final Color color;
  final IconData icon;
}
