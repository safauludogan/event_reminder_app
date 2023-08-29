import 'package:event_reminder_app/core/authentication_manager/authentication_manager.dart';
import 'package:event_reminder_app/core/components/widgets/title_widget.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({required String title, super.key})
      : super(
          centerTitle: false,
          title: TitleView(text: title),
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(StringConstants.logout),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                AuthenticationManager().logOut();
              }
            }),
          ],
        );
}
