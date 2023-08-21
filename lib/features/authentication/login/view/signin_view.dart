import 'package:auto_route/auto_route.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/main.dart';
import 'package:event_reminder_app/product/components/firebase_richtext.dart';
import 'package:event_reminder_app/product/firebase/firebase_oauth_buttons.dart';
import 'package:event_reminder_app/product/navigator/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

@RoutePage()
class SignInView extends StatefulWidget {
  const SignInView({super.key});
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Center(
          child: FirebaseUIActions(
            actions: [
              AuthStateChangeAction<SignedIn>(
                (context, state) {
                  //state.user?.sendEmailVerification();
                  if (state.user?.emailVerified != null &&
                      state.user!.emailVerified) {
                    print(state.user);
                    //Navigator.pushNamed(context, '/verify-email');
                  } else {
                    print(state.user);

                    print('Email has not been verified');
                  }
                },
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
                    title: "Don't have an account?",
                    subtitle: ' Register',
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
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        child: const Text('Logout'),
                      )
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
