import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAlertDialog(BuildContext context, String msg, dynamic url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('알림'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dialog close
              Get.to(url);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
