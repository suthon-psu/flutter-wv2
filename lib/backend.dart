import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewBackend {
  final keepAlive = InAppWebViewKeepAlive();
  HeadlessInAppWebView? wv;
  Completer<bool>? initCompleter;
  Completer<dynamic>? c;

  Future<bool> init(String uri) {
    initCompleter = Completer<bool>();
    wv = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(uri)),
      onWebViewCreated: (controller) {
        controller.addJavaScriptHandler(
            handlerName: 'onData',
            callback: (args) {
              c?.complete(args[0]);
              c = null;
            });
        initCompleter?.complete(true);
      },
      onReceivedHttpError: (controller, request, error) {
        debugPrint(request.toString());
        debugPrint(error.toString());
      },
    );
    wv?.run();

    return initCompleter!.future;
  }

  Future<dynamic> call(String uri) async {
    if (wv?.webViewController == null) {
      return false;
    }
    c = Completer<dynamic>();
    await wv?.webViewController
        ?.loadUrl(urlRequest: URLRequest(url: WebUri(uri)));
    return c?.future;
  }
}
