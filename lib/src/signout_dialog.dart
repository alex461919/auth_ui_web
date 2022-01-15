import 'dart:async';
import 'dart:html';

Future<bool> signOutDialog(DivElement container) {
  final signOutContainer = DivElement()
    ..innerHtml = '''
<div class="mdl-card mdl-shadow--2dp firebaseui-container firebaseui-id-page-sign-out">
  <div class="firebaseui-card-header"><h1 class="firebaseui-title">You have already signed in</h1></div>
  <div class="firebaseui-card-content">
    <div class="firebaseui-text">
      <center><p>Do you want to sign out?</p></center>
      <br />
    </div>
  </div>
  <div class="firebaseui-card-actions">
    <div class="firebaseui-form-actions">
      <button
        id="cancel-button"
        class="firebaseui-id-secondary-link firebaseui-button mdl-button mdl-js-button mdl-button--primary"
      >
        Cancel
      </button>
      <button
        id="sign-out-button"
        class="firebaseui-id-submit firebaseui-button mdl-button mdl-js-button mdl-button--raised mdl-button--colored"
      >
        Sign out
      </button>
    </div>
  </div>
  <div class="firebaseui-card-footer"></div>
</div>
''';

  container.append(signOutContainer);
  final completer = Completer<bool>();
  Future.delayed(Duration.zero, () {
    querySelector('#sign-out-button')?.addEventListener('click', (event) {
      completer.complete(true);
    });
    querySelector('#cancel-button')?.addEventListener('click', (event) {
      completer.complete(false);
    });
  });
  return completer.future..whenComplete(signOutContainer.remove);
}
