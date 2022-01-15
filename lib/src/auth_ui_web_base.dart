import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:firebase/firebase.dart';
import 'package:js/js.dart';
import 'overlay_container.dart';
import 'firebaseui_interop.dart';
import 'signout_dialog.dart';

Future<void> startAuthUI(Config config, [App? app]) async {
  //
  final _auth = app == null ? auth() : auth(app);
  final overlay = FirebaseAuthWrapper();
  late final AuthUI authUi;

  try {
    authUi = AuthUI.getInstance(_auth.app.name) ?? AuthUI(_auth.jsObject);
  } on NoSuchMethodError {
    return Future.error(
        'AuthUI is undefined. You need to include the following script and CSS file in your page\n<script src="https://www.gstatic.com/firebasejs/ui/6.0.0/firebase-ui-auth.js"></script>\n<link type="text/css" rel="stylesheet" href="https://www.gstatic.com/firebasejs/ui/6.0.0/firebase-ui-auth.css" />');
  }

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
