import 'package:auto_route/auto_route.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/main.dart';
import 'package:event_reminder_app/product/components/firebase_richtext.dart';
import 'package:event_reminder_app/product/firebase/firebase_oauth_buttons.dart';
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

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Center(
          child: FirebaseUIActions(
            actions: [
              AuthStateChangeAction<SigningUp>(
                (context, state) {
                  //state.user?.sendEmailVerification();
                  print('*' * 30);

                  print(state);
                },
              ),
            ],
            child: RegisterScreen(
              subtitleBuilder: (context, action) {
                return InkWell(
                  onTap: () {
                    getIt<AppRouter>().replace(const SignInRoute());
                  },
                  child: const FirebaseRichText(
                    title: 'Do you have an account?',
                    subtitle: ' SignIn',
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
                            listener: (oldState, newState, controller) {},
                            firebaseAuthButton: GoogleAuthButton(
                              onSignedIn: (credential) {
                                print('*' * 30);
                                print(credential.user);
                                print('*' * 30);
                              },
                            ),
                          ),
                          FirebaseSocialIconButton(
                            listener: (oldState, newState, controller) {},
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
