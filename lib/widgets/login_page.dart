import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:webview/auth_data.dart';
import 'package:webview/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var backend = BackendHolder.of(context).backend;
    return Scaffold(
      body: FutureBuilder(
          future: backend.init('https://apps.tsu.ac.th/flutter'),
          builder: (context, snapshot) {
            return Center(
              child: snapshot.hasData
                  ? InAppWebView(
                      keepAlive: backend.keepAlive,
                      headlessWebView: backend.wv,
                      onWebViewCreated: (controller) {
                        controller.addJavaScriptHandler(
                            handlerName: 'myHandlerName',
                            callback: (args) {
                              debugPrint("=======> ${args.toString()}");
                              context.read<AuthData>().update(args[0]);
                              Navigator.of(context).pop();
                            });
                      },
                    )
                  : const CircularProgressIndicator(),
            );
          }),
      appBar: AppBar(
        title: const Text('Login'),
      ),
    );
  }
}
