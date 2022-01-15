# auth_ui_web

A simple package wrapper [firebaseui-web](https://github.com/firebase/firebaseui-web) for dart with dart:html and dart:js packages. And to put it simply, the usual mapper dart <--> JS + a little UI.

Flutter is not required!

Tested on google and email providers. Haven't tried the rest but should work.

The tenent technology will not work. It’s nothing difficult to draw a converter, but I don’t need it, and there’s nothing to check on.

## Usage

Example available. **Config is a JS object, so all callback`s that are present in it must be wrapped with allowInterop.**
