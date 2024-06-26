import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview/auth_data.dart';
import 'package:webview/widgets/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var authData = context.watch<AuthData>();
    return Scaffold(
      body: Center(
          child: authData.name != null
              ? Text(authData.name ?? '')
              : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                  child: const Text('Login'),
                )),
      appBar: AppBar(
        title: const Text('App'),
      ),
    );
  }
}
