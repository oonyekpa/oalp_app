// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  late WebViewController webViewController;
  double progress = 0.0; // Track the loading progress.
  final String url = 'https://outlook.office.com/owa/';  // Replace with your desired URL
  bool showErrorPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Email'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                if (await webViewController.canGoBack()) {
                  await webViewController.goBack();
                } else {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                if (await webViewController.canGoForward()) {
                  await webViewController.goForward();
                } else {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                progress = 0.0;
                webViewController.reload();
              },
            ),
          ]
      ),
      body: !showErrorPage
          ? Column(
        children: [
          LinearProgressIndicator(
            value: progress, // Set the loading progress value.
            color: Colors.lightGreenAccent,
          ),
          Expanded(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              // gestureNavigationEnabled: true, // Enable gesture-based navigation (e.g., swipe to go back/forward).
              onWebViewCreated: (WebViewController controller) {
                webViewController = controller;
              },
              onPageStarted: (String url) {
                setState(() {
                  progress = 0.0; // Reset progress when a new page starts loading.
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  progress = 1.0; // Set progress to 100% when the page finishes loading.
                });
              },
              onProgress: (int moveProgress) {
                setState(() {
                  progress = moveProgress / 100; // Update the progress value.
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
      )
    );
  }
}