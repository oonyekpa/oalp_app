// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  late WebViewController _webViewController;
  double _progress = 0.0; // Track the loading progress.
  final String url = 'https://time.olaniwunajayi.net/';  // Replace with your desired URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimeSheet'),
          actions: [
            IconButton(
                icon: const Icon(Icons.replay),
                tooltip: 'Refresh',
                onPressed: () {
                  // Call the reload() method to refresh the WebView.
                  _webViewController.reload();
                }
            ),
            IconButton(
              onPressed: () {
                _webViewController.goBack();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            IconButton(
              onPressed: () {
                _webViewController.goForward();
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ]
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progress, // Set the loading progress value.
            color: Colors.lightGreenAccent,
          ),
          Expanded(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true, // Enable gesture-based navigation (e.g., swipe to go back/forward).
              onWebViewCreated: (WebViewController controller) {
                _webViewController = controller;
              },
              onPageStarted: (String url) {
                setState(() {
                  _progress = 0.0; // Reset progress when a new page starts loading.
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  _progress = 1.0; // Set progress to 100% when the page finishes loading.
                });
              },
              onProgress: (int progress) {
                setState(() {
                  _progress = progress / 100; // Update the progress value.
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}