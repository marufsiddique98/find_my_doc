import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showAdaptiveDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Center(child: CircularProgressIndicator()),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ));
}
