// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntranetScreen extends StatefulWidget {
  const IntranetScreen({super.key});

  @override
  _IntranetScreenState createState() => _IntranetScreenState();
}

class _IntranetScreenState extends State<IntranetScreen> {
  late WebViewController _webViewController;
  double _progress = 0.0; // Track the loading progress.
  final String url = 'https://olaniwunajayi.sharepoint.com/sites/intranet';  // Replace with your desired URL
  bool showErrorPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intranet Portal'),
          // backgroundColor: Colors.blueGrey[500],
          // elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Home',
              onPressed: () {
                // Navigate to the home screen
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
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
      body: !showErrorPage
          ? Column(
          children: [
            LinearProgressIndicator(
              value: _progress, // Set the loading progress value.
              color: Colors.lightGreenAccent,
            ),
            Expanded(
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                // gestureNavigationEnabled: true, // Enable gesture-based navigation (e.g., swipe to go back/forward).
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
                onWebResourceError: (error) {
                  setState(() {
                    showErrorPage = true;
                  });
                },
              ),
            ),

          ],
      )
          : Container(
              width: MediaQuery.of(context).size.width, // Get screen width.
              height: MediaQuery.of(context).size.height, // Get screen height.
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/bg2.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                ),
              ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Oops! Something went wrong.',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'The requested webpage is currently unavailable.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Hugamour', fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please check your internet connection and try again later.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Hugamour', fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'If the problem persists, contact support for assistance.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Hugamour', fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showErrorPage = false;
                      });
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}