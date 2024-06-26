import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview/auth_data.dart';
import 'package:webview/backend.dart';
import 'package:webview/widgets/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthData()),
  ], child: const MainApp()));
}

class BackendHolder extends InheritedWidget {
  final WebviewBackend backend;
  const BackendHolder({
    super.key,
    required super.child,
    required this.backend,
  });

  static BackendHolder of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BackendHolder>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BackendHolder(
      backend: WebviewBackend(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
