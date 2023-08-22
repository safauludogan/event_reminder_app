import 'package:auto_route/auto_route.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/features/authentication/login/authantication_viewmodel.dart';
import 'package:event_reminder_app/main.dart';
import 'package:event_reminder_app/product/components/firebase_richtext.dart';
import 'package:event_reminder_app/product/firebase/firebase_oauth_buttons.dart';
import 'package:event_reminder_app/product/navigator/app_router.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

@RoutePage()
class SignInView extends StatefulWidget {
  const SignInView({super.key});
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends AuthanticationViewModel<SignInView> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Center(
          child: FirebaseUIActions(
            actions: [
              AuthStateChangeAction<SignedIn>(
                (context, state) async {},
              ),
            ],
            child: SignInScreen(
              /* headerBuilder: (context, constraints, shrinkOffset) {
                return const Column(
                  children: [
                    Text('Sign in'),
                  ],
                );
              },*/
              subtitleBuilder: (context, action) {
                return InkWell(
                  onTap: () {
                    getIt<AppRouter>().push(const RegisterRoute());
                  },
                  child: const FirebaseRichText(
                    title: StringConstants.dontYouHaveAnAcc,
                    subtitle: ' ${StringConstants.register}',
                  ),
                );
              },
              showAuthActionSwitch: false,
              footerBuilder: (context, action) {
                return Padding(
                  padding: context.paddingTopLow,
                  child: Row(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
