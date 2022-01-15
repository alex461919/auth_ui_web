import 'dart:html';
import 'dart:js';
import 'package:auth_ui_web/auth_ui_web.dart';
import 'package:firebase/firebase.dart' hide ActionCodeSettings;

void main() {
  final signin = ButtonElement()
    ..style.margin = '16px 16px 16px 0'
    ..style.width = 'max-content'
    ..innerText = 'Sign In';

  final signout = ButtonElement()
    ..style.margin = '16px 0'
    ..style.width = 'max-content'
    ..innerText = 'Sign out';

  final displayName = DivElement()
    ..style.margin = '16px auto'
    ..style.width = 'max-content';

  final email = DivElement()
    ..style.margin = '16px auto'
    ..style.width = 'max-content';

  final provider = DivElement()
    ..style.margin = '16px auto'
    ..style.width = 'max-content';

  final emailVerified = DivElement()
    ..style.margin = '16px auto'
    ..style.width = 'max-content';

  final status = DivElement()
    ..style.margin = '16px auto'
    ..style.width = 'max-content';

  querySelector('#app')?.children = [
    DivElement()
      ..style.boxShadow = '1px 1px 5px 1px #e0e0e0'
      ..style.margin = '32px auto'
      ..style.padding = '16px 32px'
      ..style.width = 'max-content'
      ..children = [
        status,
        DivElement()
          ..style.margin = '16px auto'
          ..style.width = 'max-content'
          ..children = [
            displayName,
            email,
            provider,
            emailVerified,
          ],
        DivElement()
          ..style.display = 'flex'
          ..style.justifyContent = 'flex-end'
          ..children = [
            signin,
            signout,
          ],
      ]
  ];

  final uiConfig = Config(
    signInFlow: 'popup',
    signInOptions: [
      SignInOption(provider: GoogleAuthProvider.PROVIDER_ID),
/*
      EmailSignInOption(
        provider: EmailAuthProvider.PROVIDER_ID,
        signInMethod: 'emailLink',
        emailLinkSignIn:
            allowInterop(() => ActionCodeSettings(url: '127.0.0.1/', handleCodeInApp: true)),
      )
      */
      SignInOption(provider: EmailAuthProvider.PROVIDER_ID)
    ],
    callbacks: Callbacks(
      signInSuccessWithAuthResult: allowInterop(
        (dynamic authResult, [String? redirectUrl]) {
          try {
            final result = UserCredential.fromJsObject(authResult);
            final user = result.user;
            final additionalUserInfo = result.additionalUserInfo;
            provider.innerText = 'additionalUserInfo.providerId: ${additionalUserInfo.providerId}';
            if (additionalUserInfo.providerId == EmailAuthProvider.PROVIDER_ID && additionalUserInfo.isNewUser) {
              user?.sendEmailVerification();
            }
            // ignore: empty_catches
          } catch (e) {}
          return false;
        },
      ),
    ),
    tosUrl: 'https://www.google.com',
    privacyPolicyUrl: 'https://www.google.com',
  );
  auth().onAuthStateChanged.listen((user) {
    if (user != null) {
      status
        ..innerText = 'Logged in!'
        ..style.color = 'green';
      displayName.innerText = 'displayName: ${auth().currentUser?.displayName}';
      email.innerText = 'email: ${auth().currentUser?.email}';
      emailVerified.innerText = 'email verified: ${user.emailVerified ? "yes" : "no"}';
    } else {
      displayName.innerText = email.innerText = emailVerified.innerText = provider.innerText = '';
      status
        ..innerText = 'Not logged in!'
        ..style.color = 'red';
    }
  });
  signin.addEventListener('click', (event) => startAuthUI(uiConfig));
  signout.addEventListener('click', (event) => auth().signOut());
}
