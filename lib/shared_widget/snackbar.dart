// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

 showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(days: 1),
      content: Text(text),
      action: SnackBarAction(label: "close", onPressed: () {}),
    ));
 }