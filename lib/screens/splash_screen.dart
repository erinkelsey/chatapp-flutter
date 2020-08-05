import 'package:flutter/material.dart';

/// Widget for building the splash screen, which is displayed
/// while determining if user is already authenticated.
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
