// ignore_for_file: non_constant_identifier_names
@JS()
library firebaseui.web;

import 'package:js/js.dart';
import 'package:js/js_util.dart' show promiseToFuture;

Promise<T> Function() futureFnToPromise0<T>(Future<T> Function() fn) => () => Promise<T>(
      allowInterop(
        (resolv, reject) {
          fn().then(resolv).catchError(reject);
        },
      ),
    );
Promise<T> Function(A1) futureFnToPromise1<T, A1>(Future<T> Function(A1) fn) => (A1 arg1) => Promise<T>(
      allowInterop(
        (resolv, reject) {
          fn(arg1).then(resolv).catchError(reject);
        },
      ),
    );
Promise<T> Function(A1, A2) futureFnToPromise2<T, A1, A2>(Future<T> Function(A1, A2) fn) => (A1 arg1, A2 arg2) => Promise<T>(
      allowInterop(
        (resolv, reject) {
          fn(arg1, arg2).then(resolv).catchError(reject);
        },
      ),
    );

//
@JS('console')
// ignore: camel_case_types
class console {
  external static void log([dynamic arg0, dynamic arg1, dynamic arg2, dynamic arg3]);
  external static void error([dynamic arg0, dynamic arg1, dynamic arg2, dynamic arg3]);
}

@JS()
class Promise<T> {
  external factory Promise(void Function(void Function([T result]) resolve, Function reject) executor);
  external Promise then(void Function([T result]) onFulfilled, [Function onRejected]);
  external factory Promise.resolve([T result]);
  external factory Promise.reject([dynamic error]);
  external factory Promise.all(Promise<dynamic> arg0,
      [Promise<dynamic> arg1,
      Promise<dynamic> arg2,
      Promise<dynamic> arg3,
      Promise<dynamic> arg4,
      Promise<dynamic> arg5,
      Promise<dynamic> arg6]);
}

@JS('Object')
abstract class _Object {
  external static T Function<T>(T arg0, [dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4, dynamic arg5]) assign;
}

T objectAssign<T>(T arg0, [dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4, dynamic arg5]) {
  return _Object.assign(arg0, arg1, arg2, arg3, arg4, arg5);
}

/// https://github.com/firebase/firebaseui-web/tree/master/types/index.d.ts for the JS API
///
///
@anonymous
@JS()
class Callbacks {
  external bool Function(dynamic authResult, [String? redirectUrl])? get signInSuccessWithAuthResult;
  external dynamic /*Promise<void>|void*/ Function(AuthUIError error)? get signInFailure;
  external void Function()? get uiShown;
  external factory Callbacks({
    bool Function(dynamic authResult, [String? redirectUrl])? signInSuccessWithAuthResult,
    dynamic /*Promise<void>|void*/ Function(AuthUIError error)? signInFailure,
    void Function()? uiShown,
  });
}

@anonymous
@JS()
abstract class SignInOption {
  external String get provider;
  external String? get providerName;
  external String? get fullLabel;
  external String? get buttonColor;
  external String? get iconUrl;
  external dynamic /*String|RegExp*/ get hd;
  external factory SignInOption({
    required String provider,
    String? providerName,
    String? fullLabel,
    String? buttonColor,
    String? iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class SamlSignInOption implements SignInOption {
  external factory SamlSignInOption({
    required String provider,
    String? providerName,
    String? fullLabel,
    required String buttonColor,
    required String iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class FederatedSignInOption implements SignInOption {
  external String? get authMethod;
  external String? get clientId;
  external List<String>? get scopes;
  external dynamic get customParameters;
  external factory FederatedSignInOption({
    String authMethod,
    String clientId,
    List<String> scopes,
    dynamic customParameters,
    required String provider,
    String? providerName,
    String? fullLabel,
    String? buttonColor,
    String? iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class OAuthSignInOption implements SignInOption {
  external List<String>? get scopes;
  external dynamic get customParameters;
  external String? get loginHintKey;
  external factory OAuthSignInOption({
    List<String> scopes,
    dynamic customParameters,
    String loginHintKey,
    required String provider,
    String? providerName,
    String? fullLabel,
    String? buttonColor,
    String? iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class OidcSignInOption implements SignInOption {
  external dynamic get customParameters;
  external factory OidcSignInOption({
    dynamic customParameters,
    required String provider,
    String? providerName,
    String? fullLabel,
    String? buttonColor,
    String? iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class ActionCodeSettings {
  external String get url;
  external bool? get handleCodeInApp;
  external ActionCodeSettingsIOS? get IOS;
  external ActionCodeSettingsAndroid? get android;
  external String? get dynamicLinkDomain;
  external factory ActionCodeSettings(
      {required String url,
      bool? handleCodeInApp,
      String? dynamicLinkDomain,
      ActionCodeSettingsAndroid? android,
      ActionCodeSettingsIOS? IOS});
}

//--------------------------
@anonymous
@JS()
abstract class ActionCodeSettingsIOS {
  external String get bundleId;
  external factory ActionCodeSettingsIOS({String bundleId});
}

@anonymous
@JS()
abstract class ActionCodeSettingsAndroid {
  external String get packageName;
  external bool? get installApp;
  external String? get minimumVersion;
  external factory ActionCodeSettingsAndroid({
    required String packageName,
    bool? installApp,
    String? minimumVersion,
  });
}

@anonymous
@JS()
abstract class DisableSignUpConfig {
  external bool get status;
  external String? get adminEmail;
  external String? get helpLink;
  external factory DisableSignUpConfig({required bool status, String? adminEmail, String? helpLink});
}

@anonymous
@JS()
abstract class EmailSignInOption implements SignInOption {
  external bool? get forceSameDevice;
  external bool? get requireDisplayName;
  external String? get signInMethod;
  external ActionCodeSettings? Function() get emailLinkSignIn;
  external DisableSignUpConfig? get disableSignUp;
  external factory EmailSignInOption({
    bool? forceSameDevice,
    bool? requireDisplayName,
    String? signInMethod,
    ActionCodeSettings? Function() emailLinkSignIn,
    DisableSignUpConfig? disableSignUp,
    required String provider,
    String? providerName,
    String? fullLabel,
    String? buttonColor,
    String? iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class PhoneSignInOption implements SignInOption {
  external RecaptchaParameters? get recaptchaParameters;
  external String? get defaultCountry;
  external String? get defaultNationalNumber;
  external String? get loginHint;
  external List<String>? get whitelistedCountries;
  external List<String>? get blacklistedCountries;
  external factory PhoneSignInOption({
    RecaptchaParameters? recaptchaParameters,
    String? defaultCountry,
    String? defaultNationalNumber,
    String? loginHint,
    List<String>? whitelistedCountries,
    List<String>? blacklistedCountries,
    required String provider,
    String? providerName,
    String? fullLabel,
    String? buttonColor,
    String? iconUrl,
    dynamic /*String|RegExp*/ hd,
  });
}

@anonymous
@JS()
abstract class RecaptchaParameters {
  external String? get type;
  external String? get size;
  external String? get badge;
  external factory RecaptchaParameters({String? type, String? size, String? badge});
}

// Module firebaseui.auth
@anonymous
@JS()
abstract class Config {
  external bool? get autoUpgradeAnonymousUsers;
  external Callbacks? get callbacks;
  external String? get credentialHelper;
  external bool? get immediateFederatedRedirect;
  external bool? get popupMode;
  external String? get queryParameterForSignInSuccessUrl;
  external String? get queryParameterForWidgetMode;
  external String? get signInFlow;
  external List<
          dynamic /*String|FederatedSignInOption|EmailSignInOption|PhoneSignInOption|SamlSignInOption|OAuthSignInOption|OidcSignInOption*/ >?
      get signInOptions;
  external String? get signInSuccessUrl;
  external String? get siteName;
  external dynamic /*void Function()|String*/ get tosUrl;
  external dynamic /*void Function()|String*/ get privacyPolicyUrl;
  external String? get widgetUrl;
  external DisableSignUpConfig? get adminRestrictedOperation;
  external factory Config(
      {bool? autoUpgradeAnonymousUsers,
      Callbacks? callbacks,
      String? credentialHelper,
      bool? immediateFederatedRedirect,
      bool? popupMode,
      String? queryParameterForSignInSuccessUrl,
      String? queryParameterForWidgetMode,
      String? signInFlow,
      List<dynamic /*String|FederatedSignInOption|EmailSignInOption|PhoneSignInOption|SamlSignInOption|OAuthSignInOption|OidcSignInOption*/ >?
          signInOptions,
      String? signInSuccessUrl,
      String? siteName,
      dynamic /*void Function()|String*/ tosUrl,
      dynamic /*void Function()|String*/ privacyPolicyUrl,
      String? widgetUrl,
      DisableSignUpConfig? adminRestrictedOperation});
}

@JS('firebaseui.auth.AuthUI')
class AuthUI {
  external static AuthUI? /*AuthUI|Null*/ getInstance([String? appId]);
  external factory AuthUI(dynamic auth, [String? appId]);
  external void disableAutoSignIn();
  external void start(dynamic /*String|Element*/ element, Config config);
  external void setConfig(Config config);
  external void signIn();
  external void reset();
  external bool isPendingRedirect();
}

@JS('firebaseui.auth.AuthUI')
abstract class _AuthUI {
  external Promise<void> delete();
}

extension AuthUIExtensions on AuthUI {
  Future<void> delete() {
    final Object t = this;
    final tt = t as _AuthUI;
    return promiseToFuture(tt.delete());
  }
}

@JS('firebaseui.auth.AuthUIError')
class AuthUIError {
  external String get code;
  external String get message;
  external dynamic /*dynamic|Null*/ get credential;
  external dynamic toJSON();
}

@JS('firebaseui.auth.CredentialHelper')
class CredentialHelper {
  external static String get GOOGLE_YOLO;
  external static String get NONE;
}

@JS('firebaseui.auth.AnonymousAuthProvider')
class AnonymousAuthProvider {
  external static String get PROVIDER_ID;
}
