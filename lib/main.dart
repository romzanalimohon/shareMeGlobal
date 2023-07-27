import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // Completer<WebViewController> _controller = Completer<WebViewController>();
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse('https://sharemeglobal.com/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              if (await webViewController.canGoBack()) {
                webViewController.goBack();
                return false;
              } else {
                return true;
              }
            },
            child: SafeArea(
                child: WebViewWidget(
                    controller: webViewController
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)))));
  }
}
