import 'package:database_practice/Data/Local/shared_preference_service.dart';
import 'package:database_practice/signing_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  SharedPreferenceService prefs = SharedPreferenceService();

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "This is Splash Page..",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }

  /// Navigate base on value
  void whereToGo() async {
    final loginStatus = await prefs.getLoginStatus;
    Future.delayed(const Duration(seconds: 3), () {
      if (loginStatus) {
        /// ToDo: Navigate to HomePage
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SigningPage()),
        );
      }
    });
  }
}
