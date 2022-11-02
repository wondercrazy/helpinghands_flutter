import 'dart:async';

import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  final BuildContext context;

  BaseProvider(this.context) {
    Timer.run(onCreate);
  }

  @protected
  @mustCallSuper
  void onCreate() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}