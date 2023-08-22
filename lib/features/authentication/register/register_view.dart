import 'package:auto_route/auto_route.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/features/authentication/login/authantication_viewmodel.dart';
import 'package:event_reminder_app/main.dart';
import 'package:event_reminder_app/product/components/firebase/firebase_richtext.dart';
import 'package:event_reminder_app/product/components/firebase/firebase_oauth_buttons.dart';
import 'package:event_reminder_app/product/navigator/app_router.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends AuthanticationViewModel<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Center(
          child: FirebaseUIActions(
            actions: [
              AuthStateChangeAction<SigningUp>(
                (context, state) async {},
              ),
            ],
            child: RegisterScreen(
              subtitleBuilder: (context, action) {
                return InkWell(
                  onTap: () {
                    getIt<AppRouter>().replace(const SignInRoute());
                  },
                  child: const FirebaseRichText(
                    title: StringConstants.donYouHaveAnAcc,
                    subtitle: ' ${StringConstants.login}',
                  ),
                );
              },
              showAuthActionSwitch: false,
              footerBuilder: (context, action) {
                return Padding(
                  padding: context.paddingTopLow,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FirebaseSocialIconButton(
                            listener: (oldState, newState, controller) {
                              return null;
                            },
                            firebaseAuthButton: GoogleAuthButton(
                              onSignedIn: (credential) async {},
                            ),
                          ),
                          FirebaseSocialIconButton(
                            listener: (oldState, newState, controller) {
                              return null;
                            },
                            firebaseAuthButton: AppleAuthButton(),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
