# auth_ui_web

Простая обертка пакета [firebaseui-web](https://github.com/firebase/firebaseui-web) для dart с пакетами dart:html и dart:js. А если проще, обычный mapper dart <--> JS + немного UI.

Flutter не требуется!

Протестировано на провайдерах google и email. Остальный не пробовал, но должны работать.

Технология tenent работать не будет. Ничего сложного нарисовать конвертер, но мне оно без надобности, да и проверять не на чем.

## Usage

Example в наличие имеется. **Config есть объект JS, поэтому все callback`s, которые в нем присутствуют, обязательно должны быть обернуты allowInterop.**
