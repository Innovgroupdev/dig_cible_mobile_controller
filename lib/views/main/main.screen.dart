import 'package:flutter/material.dart';
import '../code/code.screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CodeScreen());
  }
}
