import 'dart:html';

import 'package:auth_ui_web/src/firebaseui_interop.dart';

class FirebaseAuthWrapper {
  //
  late final DivElement overlay;
  late final DivElement container;
  late final DivElement authBox;
  late final DivElement closeButton;
  final onCloseListeners = <void Function()>[];
  late final MutationObserver observer;
  //
  FirebaseAuthWrapper() {
    querySelector('.firebase-auth-overlay')?.remove();
    if (querySelector('style[data="firebase-auth-styles"]') == null) {
      final styles = StyleElement()
        ..setAttribute('data', 'firebase-auth-styles')
        ..innerHtml = '''
.firebase-auth-overlay {
    position: fixed;
    inset: 0;
    background-color: rgba(0, 0, 0, 0.3);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1;
    opacity: 0;
    transition: opacity .3s ease-in-out;
}
.firebase-auth-container {
    position: relative;   
}
.firebase-auth-box {
    max-height: calc(100vh - 56px);
    max-width: calc(100vw - 56px);
    overflow: auto;
    box-sizing: border-box;
    background-color: white;
    border-radius: 2px;
}
.firebase-auth-container .close-button {
    position: absolute;
    right: -1.375rem;
    top: -1.375rem;
    width: 1.5rem;
    font-size: 1.25rem;
    line-height: 1.5rem;
    text-align: center;
    cursor: pointer;
    color: #212529;
    background-color: white;
    border-radius: 50%;
    opacity: .8;
}
.firebase-auth-container .close-button:hover {
    opacity: 1;
}
''';
      document.head?.append(styles);
    }
    overlay = DivElement()..className = 'firebase-auth-overlay';
    authBox = DivElement()..className = 'firebase-auth-box';
    closeButton = DivElement()
      ..className = 'close-button'
      ..innerHtml = '&times;';

    container = DivElement()
      ..className = 'firebase-auth-container'
      ..children = [
        authBox,
        closeButton,
      ];

    document.body?.append(overlay).append(container);
    closeButton.addEventListener('click', (event) => onCloseListeners.forEach((fn) => fn()));

    observer = MutationObserver((mutations, observer) =>
        closeButton.hidden = authBox.getElementsByClassName('firebaseui-id-page-provider-sign-in').isEmpty)
      ..observe(authBox, childList: true);
  }

  void show() {
    overlay.style.display = 'flex';
    Future.delayed(Duration.zero, () => overlay.style.opacity = '1');
  }

  Future<void> hide() async {
    overlay.style.opacity = '';
    await Future.delayed(Duration(milliseconds: 300), () => overlay.style.display = 'none');
  }

  Future<void> dispose() async {
    await hide();
    observer.disconnect();
    authBox.remove();
    closeButton.remove();
    container.remove();
    overlay.remove();
    onCloseListeners.clear();
  }

  void Function() onClose(void Function() fn) {
    onCloseListeners.add(fn);
    return () => onCloseListeners.remove(fn);
  }
}
