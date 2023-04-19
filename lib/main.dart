import 'package:alpha_feedback/view/login_page.dart';
import 'package:alpha_feedback/view/profile_page.dart';
import 'package:flutter/material.dart';
main() {
  runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
// beautiful Flutter login and registration screen UI
