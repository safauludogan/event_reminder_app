import 'package:event_reminder_app/core/authentication_manager/authentication_manager.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/features/authentication/login/model/login_response_model.dart';
import 'package:event_reminder_app/product/manager/database/operations/login_hive_operation.dart';
import 'package:event_reminder_app/product/manager/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page1View extends StatefulWidget {
  const Page1View({super.key});

  @override
  State<Page1View> createState() => _Page1ViewState();
}

class _Page1ViewState extends State<Page1View> {
  @override
  void initState() {
    super.initState();
    getLoginData();
  }

  Future<void> getLoginData() async {
    await _loginHiveOperation.open();
    final result = _loginHiveOperation.getItem(LoginResponseModel().key);
  }

  final _loginHiveOperation = LoginHiveOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<ThemeManager>().changeTheme(),
              child: const Text(
                'Change Theme',
              ),
            ),
            TextButton(
              onPressed: () async => AuthenticationManager().logOut(),
              child: const Text(StringConstants.logout),
            ),
            TextButton(
              onPressed: () async {
                await _loginHiveOperation.clear();
              },
              child: Text('Delete', style: context.textTheme.bodySmall),
            )
          ],
        ),
      ),
    );
  }
}
