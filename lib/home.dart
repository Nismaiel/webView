import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';



class Home extends StatefulWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String selectedUrl = 'YOUR-URL-HERE';


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedUrl = 'https://www.chatal3rak.xyz/chat/';

  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

//  final _urlCtrl = TextEditingController(text: selectedUrl);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

//    _urlCtrl.addListener(() {
//      selectedUrl = 'https://www.chatal3rak.xyz/chat/';
//    });

    // Add a listener to on destroy WebView, so you can make came actions.
//    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
//      if (mounted) {
//        // Actions like show a info toast.
//        _scaffoldKey.currentState.showSnackBar(
//            const SnackBar(content: const Text('Webview Destroyed')));
//      }
//    });

    // Add a listener to on url changed
//    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
//      if (mounted) {
//        setState(() {
//          _history.add('onUrlChanged: $url');
//        });
//      }
//    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _history.add('onProgressChanged: $progress');
        });
      }
    });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in Y Direction: $y');
        });
      }
    });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in X Direction: $x');
        });
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          _history.add('onStateChanged: ${state.type} ${state.url}');
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });
    flutterWebViewPlugin.launch(selectedUrl);
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: WebviewScaffold(
          url: selectedUrl,
//            javascriptChannels: jsChannels,
          mediaPlaybackRequiresUserGesture: false,
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          initialChild: Container(
            color: Colors.redAccent,
            child:  Center(
              child: Image.asset('assets/logo.png',height: 150,width: 150,),
            ),
          ),

        )
      ),
    );
  }
}
