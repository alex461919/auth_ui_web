import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:js/js.dart';
import 'overlay_container.dart';
import 'firebaseui_interop.dart';
import 'signout_dialog.dart';

Future<void> startAuthUI(Config config, [App? app]) async {
  //
  final _auth = app == null ? auth() : auth(app);
  final overlay = FirebaseAuthWrapper();
  final authUi = AuthUI.getInstance(_auth.app.name) ?? AuthUI(_auth.jsObject);

  final completer = Completer()
    // ignore: unawaited_futures
    ..future.whenComplete(() {
      authUi.reset();
      overlay.dispose();
    });

  if (_auth.currentUser != null) {
    overlay.show();
    if (await signOutDialog(overlay.authBox)) {
      await _auth.signOut();
    } else {
      completer.complete();
      return completer.future;
    }
  }
  // adding service callbacks to incoming config
  final incomingSignInSuccessWithAuthResult = config.callbacks?.signInSuccessWithAuthResult;
  bool signInSuccess(dynamic authResult, [String? redirectUrl]) {
    completer.complete();
    if (incomingSignInSuccessWithAuthResult == null) return false;
    return incomingSignInSuccessWithAuthResult(authResult, redirectUrl);
  }

  final incomingSignInFailure = config.callbacks?.signInFailure;
  dynamic signInFailure(AuthUIError error) {
    completer.completeError(error);
    if (incomingSignInFailure != null) return incomingSignInFailure(error);
  }

  final incomingUiShown = config.callbacks?.uiShown;
  void uiShown() {
    overlay.show();
    if (incomingUiShown != null) return incomingUiShown();
  }

  // shallow cloning
  final _callbacks = objectAssign(
    Callbacks(),
    config.callbacks,
    Callbacks(
        signInSuccessWithAuthResult: allowInterop(signInSuccess),
        signInFailure: allowInterop(signInFailure),
        uiShown: allowInterop(uiShown)),
  );
  final _config = objectAssign(Config(), config, Config(callbacks: _callbacks));

  authUi.start(overlay.authBox, _config);

  overlay.onClose(() {
    completer.complete();
  });

  return completer.future;
}
